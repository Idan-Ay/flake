function llm
    ollama serve > /dev/null 2>&1 &
    sleep 0.1 &
    wait $last_pid
    ollama run $argv
end
