if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh
export PATH="/home/sean/.npm-global/bin/:$PATH"
export PATH="/home/sean/.local/bin/:$PATH"

if [ -f `which powerline-daemon` ]; then
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh
fi


export EDITOR='emacsclient -c'
export VISUAL='emacsclient -c'
export ALTERNATE_EDITOR=""
export GTAGSCONF=/usr/share/gtags/gtags.conf
export GTAGSLABEL=pygments
#PATH="/home/sean/perl5/bin${PATH:+:${PATH}}"; export PATH;
#PERL5LIB="/home/sean/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
#PERL_LOCAL_LIB_ROOT="/home/sean/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
#PERL_MB_OPT="--install_base \"/home/sean/perl5\""; export PERL_MB_OPT;
#PERL_MM_OPT="INSTALL_BASE=/home/sean/perl5"; export PERL_MM_OPT;

