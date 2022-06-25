# run zig from freja

## prerequisites

[freja](https://github.com/saikyun/freja)

## try it

0. `git clone https://github.com/saikyun/run-zig-from-freja`
1. `freja --dofile run-zig.janet`
2. Ctrl+P -> Choose `hello.zig` -> Enter
3. Ctrl+R to run file

## make it permanent

1. `freja --open-init`
2. Copy paste contents from `run-zig.janent` into the open file, which is your init file
3. Hit Ctrl+L or exit freja

Now you'll have access to the Ctrl+R hotkey whenever you start freja.
