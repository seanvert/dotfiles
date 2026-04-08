# 1. Volte para a sua Home
cd ~

# 2. Apague a base de dados do Bare Repo que está "travada"
rm -rf ~/.cfg

# 3. O CULPADO: Apague o repositório Git oculto dentro do XMonad
rm -rf ~/.xmonad/.git

# 4. Crie o Bare Repo do zero, limpinho
git init --bare $HOME/.cfg

# 5. Configure para ignorar arquivos não rastreados usando caminhos absolutos
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no

# 6. Adicione o arquivo do XMonad
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME add .xmonad/xmonad.hs

# 7. Verifique o status para confirmar a vitória
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME status

# 8. Adicione um alias para adicionar outras configurações mais tarde
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
