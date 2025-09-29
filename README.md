📄 Chatbot com PDFs (Streamlit + LangChain + OpenAI)

Este projeto é um chatbot simples que permite fazer perguntas sobre documentos PDF ou TXT.
Ele usa Streamlit para interface, LangChain para processamento de texto, FAISS para busca vetorial e OpenAI para gerar respostas.

🚀 Como rodar o projeto localmente
1. Clonar o repositório
git clone https://github.com/seu-usuario/chatbot-pdf.git
cd chatbot-pdf

2. Criar ambiente virtual
python -m venv .venv


Ativar no Windows (PowerShell):

.\.venv\Scripts\Activate.ps1


No Linux/Mac:

source .venv/bin/activate

3. Instalar dependências
pip install -r requirements.txt

4. Configurar variável de ambiente da OpenAI

Crie um arquivo .env na raiz com o conteúdo:

OPENAI_API_KEY=sua_chave_aqui

5. Rodar o Streamlit
streamlit run app/streamlit_app.py


Abra no navegador:
👉 http://localhost:8501

📂 Estrutura do projeto
chatbot-pdf/
│-- app/
│   └── streamlit_app.py   # Código principal do chatbot
│-- inputs/                # PDFs ou TXTs para indexação
│-- outputs/               # Índices FAISS salvos
│-- requirements.txt       # Dependências do projeto
│-- .gitignore             # Arquivos ignorados no Git
│-- README.md              # Documentação do projeto

🛠️ Tecnologias usadas

Python 3.10+
Streamlit
LangChain
FAISS
OpenAI

✅ Funcionalidades

Upload de arquivos PDF e TXT.

Geração de embeddings com OpenAI.

Armazenamento em FAISS para busca rápida.

Chat com contexto baseado no documento carregado.

🔮 Próximos passos (melhorias)

Suporte a múltiplos documentos.

Exportar histórico de chats.

Deploy no Streamlit Cloud ou Azure.
