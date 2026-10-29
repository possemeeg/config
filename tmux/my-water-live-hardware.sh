tmux start
tmux new-session -d -s my-water-live -c ${HOME}/Documents/1-projects/my-water-live 
tmux send-keys -t '1.1' 'cd ${HOME}/Documents/1-projects/my-water-live/mywater-hardware/pico/cpp/mw-updater && nvim' Enter
tmux new-window -c ${HOME}/Documents/1-projects/my-water-live
tmux split-window -v 
tmux split-window -v
tmux split-window -v
tmux send-keys -t '2.1' 'cd ${HOME}/Documents/1-projects/my-water-live/scrap/hardware-test && tail -f minicom.cap' Enter
tmux send-keys -t '2.2' 'cd ${HOME}/Documents/1-projects/my-water-live/mywater-hardware/pico/cpp/mw-updater/build' Enter
tmux send-keys -t '2.3' 'cd ${HOME}/Documents/1-projects/my-water-live/openocd && sudo src/openocd -s tcl -f interface/cmsis-dap.cfg -f target/rp2350.cfg -c "adapter speed 5000"' Enter
tmux send-keys -t '2.4' 'cd ${HOME}/Documents/1-projects/my-water-live/scrap/hardware-test && sudo minicom -D /dev/ttyACM0 -b 115200 -o' Enter
tmux select-window -t 1
tmux a -t my-water-live
