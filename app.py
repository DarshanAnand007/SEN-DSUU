import PyPDF2
from langchain_community.embeddings import OllamaEmbeddings
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_community.vectorstores import Chroma
from langchain.chains import ConversationalRetrievalChain
from langchain.memory import ChatMessageHistory, ConversationBufferMemory
import chainlit as cl
from langchain_groq import ChatGroq
from dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv()

# Function to initialize conversation chain with GROQ language model
groq_api_key = os.environ['GROQ_API_KEY']

# Initialize GROQ chat with provided API key, model name, and settings
llm_groq = ChatGroq(
    groq_api_key=groq_api_key, model_name="llama3-70b-8192",
    temperature=0.2
)

@cl.on_chat_start
async def on_chat_start():
    files = None  # Initialize variable to store uploaded files

    # Wait for the user to upload files
    while files is None:
        files = await cl.AskFileMessage(
            content="Welcome! Please upload one or more PDF files to begin analyzing them.",
            accept=["application/pdf"],
            max_size_mb=100,  # Optionally limit the file size
            max_files=10,
            timeout=180,  # Set a timeout for user response
        ).send()

    # Process each uploaded file
    texts = []
    metadatas = []
    for file in files:
        print(file)  # Print the file object for debugging

        # Read the PDF file
        pdf = PyPDF2.PdfReader(file.path)
        pdf_text = ""
        for page in pdf.pages:
            pdf_text += page.extract_text()

        # Split the text into chunks
        text_splitter = RecursiveCharacterTextSplitter(chunk_size=1200, chunk_overlap=50)
        file_texts = text_splitter.split_text(pdf_text)
        texts.extend(file_texts)

        # Create metadata for each chunk
        file_metadatas = [{"source": f"{i}-{file.name}"} for i in range(len(file_texts))]
        metadatas.extend(file_metadatas)

    # Create a Chroma vector store
    embeddings = OllamaEmbeddings(model="nomic-embed-text")
    docsearch = await cl.make_async(Chroma.from_texts)(
        texts, embeddings, metadatas=metadatas
    )

    # Initialize message history for conversation
    message_history = ChatMessageHistory()

    # Memory for conversational context
    memory = ConversationBufferMemory(
        memory_key="chat_history",
        output_key="answer",
        chat_memory=message_history,
        return_messages=True,
    )

    # Create a chain that uses the Chroma vector store
    chain = ConversationalRetrievalChain.from_llm(
        llm=llm_groq,
        chain_type="stuff",
        retriever=docsearch.as_retriever(),
        memory=memory,
        return_source_documents=True,
    )

    # Sending a welcome message and image
    elements = [
        cl.Image(name="image", display="inline", path="pic.jpg")
    ]
    msg = cl.Message(content=f"Processing {len(files)} files done. You can now ask questions!", elements=elements)
    await msg.send()

    # Store the chain in user session
    cl.user_session.set("chain", chain)

@cl.on_message
async def main(message: cl.Message):
    # Retrieve the chain from user session
    chain = cl.user_session.get("chain")
    # Callbacks happen asynchronously/parallel
    cb = cl.AsyncLangchainCallbackHandler()

    # Call the chain with user's message content
    res = await chain.ainvoke(message.content, callbacks=[cb])
    answer = res["answer"]

    # If no answer from PDF data, handle general questions
    if not answer:
        general_response = await llm_groq.agenerate({
            "prompt": message.content
        })
        answer = general_response['choices'][0]['message']['content']

    # Return results
    await cl.Message(content=answer).send()

    # Adding follow-up question button for user interaction
    await cl.Message(content="Do you have any follow-up questions?").send()
