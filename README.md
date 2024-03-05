# tmux-xdrip

Tmux plugin that displays your glucose level & direction from xDrip in your
terminal.

![xDrip Status](/screenshots/xdrip-tmux-status.png)
![xDrip Status](/screenshots/tmux-xdrip-low-example.png)
![xDrip Status](/screenshots/xdrip-tmux-status-2.png)
![xDrip Status](/screenshots/xdrip-tmux-4.png)

### Prerequisites

For this to work, you will need to ensure you are first of all _using_
[xDrip](https://xdrip.readthedocs.io/en/latest/), if not you will need to
download, install, and configure it. You will also need to ensure you have
`curl` & `jq`.

If you have done this or already have it setup, you will then need to ensure you
have the `xDrip Web Service` enabled. You can visit the
[following link](https://xdrip.readthedocs.io/en/latest/use/interapp/#web-service)
for documentation on how to do this and set it up.

**N.B**: If you are using a password, you will need to use the sha1 _hashed_
value as the api-secret, you can generate this hash like so:

```bash
echo -n "your_password" | sha1sum
```

Finally, you will need to create the following environment variables and add
then to you shell environment.

```bash
export XDRIP_SERVER="http://192.168.0.101:17580/pebble"
export XDRIP_SERVER_KEY="564e340cd48437d2dfe876ee154cc99dc4d0d137"
```

### Usage

Add `#{xdrip}` format string to your `status-*` tmux option. See the below
example.

```bash
set -g status-right "xDrip: #{xdrip} | %a %h-%d %H:%M"
```

### Installation

Add the plugin using TPM like so:

```
set -g @plugin 'Cian911/tmux-xdrip'
```
