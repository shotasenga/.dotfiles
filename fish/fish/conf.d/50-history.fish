function sync_history -e fish_preexec -d "Sync history between the settions"
    history --merge
end
