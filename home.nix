{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gotcha";
  home.homeDirectory = "/Users/gotcha";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.fd
    pkgs.just

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gotcha/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = false;

  programs.zsh.enable = true;
  programs.zsh.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git.enable = true;
  programs.git.aliases = {
    co = "checkout";
    st = "status";
  }; 
  programs.git.includes = [
    { path = "~/.config/git/git-credential-oauth.inc"; }
  ];
  programs.git.userName = "Godefroid Chapelle";
  programs.git.userEmail = "gotcha@bubblenet.be";

  programs.bat.enable = true;

  programs.bottom.enable = true;

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.vimAlias = true;
  programs.neovim.plugins = with pkgs.vimPlugins; [
    fugitive
    vinegar
    vimelette
    bufexplorer
    telescope-nvim
    nvim-treesitter
    surround
    vim-commentary
    gitsigns-nvim
    lualine-nvim
    vim-obsession
  ];
  programs.neovim.extraConfig = ''
    let mapleader=","
    " Fugitive
    nnoremap <leader>gs :G<cr>
    nnoremap <leader>b :BufExplorer<cr>
  '';

  programs.tmux.enable = true;
  programs.tmux.prefix = "C-a";
  programs.tmux.plugins = with pkgs.tmuxPlugins; [
    sessionist
  ];

  programs.mcfly.enable = true;
  programs.mcfly.enableZshIntegration = true;

  programs.ripgrep.enable = true;

  programs.git-credential-oauth.enable = true;

  xdg.enable = true;
  xdg.configFile."git/git-credential-oauth.inc".text = ''
    [credential]
    helper = osxkeychain
    helper = cache --timeout 7200	# two hours
    helper = oauth
  '';

}
