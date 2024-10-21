## plugin cacheを無効化する方法

- Server Configuration で、`use-tf-plugin-cache: false` と指定する

## plugin cache 無効化時の挙動

- plan・apply 実行時に、`/home/atlantis/.atlantis/plugin-cache/registry.terraform.io/hashicorp/aws` にプラグインがキャッシュされなくなる
- PR単位でのlock機能については、plugin cache を無効にしても作動する
