{
  description = "Just a dev shell for now";
  inputs.basic-dev-shell.url = "github:necauqua/basic-dev-shell";
  outputs = { self, basic-dev-shell }:
    basic-dev-shell.make (pkgs: with pkgs; [ hugo go ]);
}
