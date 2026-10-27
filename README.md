# Amurel ZIP

![Logotipo da AMUREL](CPP/7zip/UI/FileManager/AmurelLogo.png)

Esta é uma personalização dos fontes do 7-Zip 26.05 com a identidade visual
da AMUREL. O nome exibido e o ícone das interfaces gráficas foram adaptados;
os créditos e avisos de licença do projeto original permanecem nos arquivos
em `DOC`.

Os menus principais, a barra de ferramentas, as opções do gerenciador e os
diálogos de compactação e extração foram traduzidos para português do Brasil.
O instalador MSI também está em português. Algumas janelas auxiliares e a
documentação de ajuda original ainda podem conter textos em inglês. Os nomes
internos usados para compatibilidade com as configurações e integrações
existentes do 7-Zip foram preservados.

Consulte [DOC/Guia-Amurel-ZIP.md](DOC/Guia-Amurel-ZIP.md) para instruções em
português, incluindo criação de ZIP e extração de vários formatos. A janela de
compactação passa a selecionar ZIP por padrão em uma instalação nova, sem
remover os outros formatos que a compilação oferece. Para extrair RAR, a
compilação deve incluir os decodificadores RAR; não defina
`DISABLE_RAR_COMPRESS=1`.

## Instalador MSI

Compile também os alvos x64 da interface gráfica, da extensão do Explorador e
dos codecs externos. O script requer `7zFM.exe`, `7zG.exe`, `7z.dll` e
`7-zip.dll` nos respectivos diretórios `x64`. Em seguida, gere o instalador com
`installer\build-msi.ps1`. É necessário ter o WiX Toolset 3.14 disponível no
`PATH` ou instalado no caminho padrão. O MSI resultante fica em
`dist\AMUREL-ZIP-26.05.1-x64.msi`. Ele instala a integração de menu de
contexto, incluindo **Compactar com AMUREL ZIP** ao clicar com o botão direito
em uma pasta. O instalador não altera associações de formatos de arquivo.
