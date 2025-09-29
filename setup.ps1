<#
Script: setup.ps1
Objetivo: Configuração completa do projeto Chat com PDFs (DIO) - Versão simplificada
#>

Write-Host "Iniciando configuração completa do projeto Chat com PDFs..." -ForegroundColor Cyan

# 1 - Apagar venv antigo (se existir)
if (Test-Path ".venv") {
    Write-Host "Apagando .venv antigo..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force .venv
}

# 2 - Criar novo venv
Write-Host "Criando novo ambiente virtual (.venv)..." -ForegroundColor Yellow
python -m venv .venv

# 3 - Ativar venv
Write-Host "Ativando ambiente virtual..." -ForegroundColor Yellow
.venv\Scripts\Activate.ps1

# 4 - Criar requirements.txt atualizado
Write-Host "Criando requirements.txt..." -ForegroundColor Yellow
@"
streamlit==1.50.0
PyPDF2==2.11.3
openai==1.109.1
faiss-cpu==1.12.0
"@ | Out-File -Encoding UTF8 requirements.txt

# 5 - Atualizar pip e instalar dependências
Write-Host "Atualizando pip e instalando dependências..." -ForegroundColor Yellow
python -m pip install --upgrade pip setuptools wheel
python -m pip install -r requirements.txt

# 6 - Criar pastas inputs e outputs
Write-Host "Criando pastas inputs/ e outputs/..." -ForegroundColor Yellow
if (!(Test-Path "inputs")) { New-Item -ItemType Directory -Path "inputs" }
if (!(Test-Path "outputs")) { New-Item -ItemType Directory -Path "outputs" }

# 7 - Criar arquivo de exemplo inputs/sentencas.txt
$sentencasFile = "inputs\sentencas.txt"
if (!(Test-Path $sentencasFile)) {
    Write-Host "Criando inputs/sentencas.txt com frases de exemplo..." -ForegroundColor Yellow
    @"
Este é um exemplo de frase para teste do chatbot.
Use arquivos PDF ou TXT na pasta inputs/ para criar o índice.
"@ | Out-File -Encoding UTF8 $sentencasFile
} else {
    Write-Host "Arquivo sentencas.txt já existe." -ForegroundColor Green
}

# 8 - Finalização
Write-Host "Configuração concluída com sucesso!" -ForegroundColor Green
Write-Host ""
Write-Host "Para iniciar o chat, rode:" -ForegroundColor Cyan
Write-Host ".\.venv\Scripts\Activate.ps1" -ForegroundColor White
Write-Host "python -m streamlit run app/streamlit_app.py" -ForegroundColor Cyan
Write-Host "E abra o navegador em http://localhost:8501" -ForegroundColor Cyan
