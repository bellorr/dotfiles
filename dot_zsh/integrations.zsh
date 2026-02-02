#### Shell integrations ####
if [ -f "/Users/nrebello/.tunnel-goat/shellrc_helper" ]; then
    source "/Users/nrebello/.tunnel-goat/shellrc_helper";
fi

## kubejumper shell integration
[ -f /Users/nrebello/.config/kubejumper/kubejumper.sh ] && source /Users/nrebello/.config/kubejumper/kubejumper.sh
