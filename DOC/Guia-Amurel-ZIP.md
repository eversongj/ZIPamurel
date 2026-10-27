# Amurel ZIP — guia rápido para os municípios

O Amurel ZIP é uma personalização do 7-Zip para trabalhar com arquivos
compactados. Este guia foi escrito para esta edição e complementa a
documentação original, que permanece nos idiomas e termos em que foi
distribuída. A interface do programa também ainda está majoritariamente em
inglês. Os menus principais, os rótulos da barra de ferramentas e as opções do
menu de contexto já estão em português; algumas janelas, como as de
compactação e extração, ainda exibem textos em inglês.

Os cabeçalhos das colunas, como **Nome**, **Tamanho total**, **Espaço livre**,
**Tipo**, **Rótulo** e **Sistema de arquivos**, também estão traduzidos.
Identificadores padronizados fornecidos pelo Windows, como **NTFS** e
**FAT32**, permanecem inalterados.

## Criar arquivos compactados

O formato **ZIP** é a opção inicial recomendada para compartilhar arquivos
com diferentes órgãos e sistemas. Ao criar um arquivo, selecione os documentos
e use **Adicionar**. Confira o nome e a pasta de destino e, no campo
**Archive format**, escolha **zip**. Ajuste as demais opções somente quando
necessário e confirme a operação.

O programa também pode oferecer outros formatos de criação, conforme os
componentes incluídos na compilação. O formato selecionado por último pode ser
lembrado pelo aplicativo; ao escolher outro formato de destino, verifique a
opção **Archive format** antes de iniciar.

## Abrir e extrair um arquivo

1. Abra o Amurel ZIP e localize a pasta onde está o arquivo compactado.
2. Selecione o arquivo e clique em **Extrair**.
3. Escolha uma pasta de destino. Para facilitar a conferência, prefira uma
   pasta nova, em vez de extrair diretamente sobre documentos existentes.
4. Se o arquivo pedir uma senha, informe a senha fornecida pelo remetente.
5. Ao terminar, confira os arquivos extraídos antes de utilizá-los ou
   encaminhá-los.

Se a integração com o menu de contexto estiver instalada e ativada, clique
com o botão direito sobre o arquivo e escolha uma opção de extração do
Amurel ZIP, como **Extrair arquivos...** ou **Extrair aqui**.
Os nomes e as opções disponíveis podem variar conforme a instalação e a
versão do Windows.

## Extrair arquivos RAR

O Amurel ZIP pode **abrir e extrair** arquivos RAR e RAR5, desde que a edição
tenha sido compilada com os componentes de descompactação RAR. A compilação
completa do projeto inclui esses componentes por padrão. Não use
`DISABLE_RAR_COMPRESS=1` na compilação: essa opção remove os decodificadores
necessários para extrair o conteúdo compactado de arquivos RAR.

Na interface gráfica, abra o arquivo `.rar` no Amurel ZIP, clique em
**Extrair**, escolha o destino e confirme. Arquivos protegidos por senha
solicitarão a senha durante a extração.

## Formatos de extração

Com a compilação completa, o programa pode abrir e extrair os formatos
reconhecidos pelos módulos do 7-Zip incluídos nessa edição, como 7z, ZIP,
RAR/RAR5, TAR, GZIP, BZIP2, XZ, ISO, CAB e outros formatos de arquivo e de
imagem de disco. A relação efetiva depende dos módulos compilados e da versão
do formato. Isso não significa compatibilidade com todo formato existente.
Ao distribuir o programa, inclua o componente completo de formatos (7z.dll)
ou compile a versão de console completa (Alone2); versões reduzidas podem
aceitar menos formatos.

Também é possível usar a linha de comando, se o executável `7z.exe` estiver
instalado:

```text
7z x "C:\caminho\arquivo.rar" -o"C:\caminho\destino"
```

O comando `x` mantém a estrutura de pastas do arquivo. Ajuste os caminhos para
o local do arquivo e para a pasta de destino. Se o sistema não encontrar
`7z.exe`, use o caminho completo para o executável ou a interface gráfica.

### Arquivos RAR divididos em partes

Mantenha todas as partes recebidas na mesma pasta e inicie a extração pela
primeira parte — por exemplo, `arquivo.part1.rar` ou, em conjuntos antigos,
`arquivo.rar`. Não renomeie as partes. Se alguma parte estiver ausente ou
danificada, solicite ao remetente um novo conjunto completo.

## Limites importantes

- Esta edição permite **extrair** RAR; não cria arquivos RAR. ZIP é a opção
  inicial recomendada para criar arquivos compartilháveis; a lista de outros
  formatos de criação depende da compilação.
- Um arquivo protegido por senha não pode ser extraído sem a senha correta.
- Um arquivo incompleto, corrompido ou incompatível pode não ser extraído.
  Se isso ocorrer, solicite uma nova cópia ao remetente.
- A possibilidade de abrir um formato não garante que o conteúdo seja seguro.
  Não execute arquivos inesperados e siga as orientações de segurança de
  tecnologia da informação do seu município.

## Cuidados com documentos municipais

- Confira se a origem e o destinatário do arquivo são confiáveis.
- Extraia para uma pasta apropriada, com acesso autorizado, e evite sobrescrever
  documentos existentes sem antes conferir o conteúdo.
- Preserve os originais e siga as regras municipais de cópia de segurança,
  retenção, acesso e compartilhamento de documentos.
- Não compartilhe senhas ou informações protegidas junto com o arquivo sem
  seguir os procedimentos de segurança do município.

## Licenças e créditos

O Amurel ZIP é baseado nos fontes do 7-Zip. Os avisos de direitos autorais,
licenças e restrições dos componentes originais, inclusive do suporte a RAR,
estão preservados nos arquivos de licença distribuídos com o projeto, em
`DOC/License.txt`, `DOC/copying.txt` e `DOC/unRarLicense.txt`. Consulte esses
arquivos antes de redistribuir os executáveis.
