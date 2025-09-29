import streamlit as st
import os
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.document_loaders import TextLoader, PyPDFLoader
from langchain.vectorstores import FAISS
from langchain.embeddings.openai import OpenAIEmbeddings
from langchain.chat_models import ChatOpenAI

st.title("📄 Chat PDF Simples")

INPUT_DIR = "inputs"
INDEX_PATH = "outputs/vectorstore"

os.makedirs(INPUT_DIR, exist_ok=True)
os.makedirs("outputs", exist_ok=True)

# Upload PDF ou TXT
uploaded_file = st.file_uploader("Escolha um arquivo PDF ou TXT", type=["pdf", "txt"])

if uploaded_file:
    file_path = os.path.join(INPUT_DIR, uploaded_file.name)
    with open(file_path, "wb") as f:
        f.write(uploaded_file.getbuffer())
    st.success(f"Arquivo {uploaded_file.name} salvo em {INPUT_DIR}/")

    # Carrega documentos
    if uploaded_file.name.endswith(".pdf"):
        loader = PyPDFLoader(file_path)
    else:
        loader = TextLoader(file_path, encoding="utf-8")
    documents = loader.load()

    # Divide textos
    splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=100)
    docs = splitter.split_documents(documents)

    # Cria embeddings e salva índice
    st.info("Criando índice FAISS...")
    embeddings = OpenAIEmbeddings()
    vectorstore = FAISS.from_documents(docs, embeddings)
    vectorstore.save_local(INDEX_PATH)
    st.success("Índice criado e salvo com sucesso!")

# Carrega índice FAISS existente
if os.path.exists(INDEX_PATH):
    vectorstore = FAISS.load_local(INDEX_PATH, OpenAIEmbeddings())
else:
    st.warning("Nenhum índice encontrado. Faça upload de um arquivo para criar o índice.")
    st.stop()

# Chat
st.header("💬 Faça sua pergunta:")
query = st.text_input("Digite sua pergunta aqui:")

if query:
    chat_model = ChatOpenAI(temperature=0)
    docs = vectorstore.similarity_search(query)
    context = "\n".join([d.page_content for d in docs])
    response = chat_model([{"role": "system", "content": context},
                           {"role": "user", "content": query}])
    st.write(response.content)
