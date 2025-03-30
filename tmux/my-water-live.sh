tmux start
tmux new-session -d -s my-water-live -c ${HOME}/Documents/1-projects/my-water-live 
tmux send-keys -t '1.1' 'nvim' Enter
tmux new-window -c ${HOME}/Documents/1-projects/my-water-live
tmux split-window -v -c ${HOME}/Documents/1-projects/my-water-live/mywater-api 
tmux send-keys -t '2.1' 'cd mywater-fe && yarn dev' Enter
tmux send-keys -t '2.2' 've go mywater-api && . ../env/mywater-api.env && run-api --reload' Enter
tmux select-window -t 1
tmux a -t my-water-live
