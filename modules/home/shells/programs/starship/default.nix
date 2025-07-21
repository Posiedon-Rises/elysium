{
  lib,
  ...
}:

{
  programs.starship = {
    enable = false;
    settings = {
      add_newline = false;

      format = lib.strings.concatStringsSep "" [
        "[╭](fg:bright-black)"
        "[](fg:green)"
        "$username$hostname"
        "[](fg:green bg:cyan)"
        "$directory"
        "[](fg:cyan bg:blue)"
        "$dotnet"
        "$rust"
        "[](fg:blue bg:purple)"
        "$git_branch"
        "[](fg:purple)"
        "$line_break"
        "[╰](fg:bright-black)"
        "$character"
      ];

      username = {
        format = "[$user@](fg:bold black bg:green)";
        show_always = true;
      };

      hostname = {
        ssh_only = false;
        style = "fg:bold black bg:green";
        format = "[$hostname]($style)";
      };

      directory = {
        format = "[$read_only]($read_only_style)[$path]($style)";
        style = "fg:bold black bg:cyan";
        read_only_style = "fg:bold red bg:cyan";
        truncation_symbol = "…/";
        read_only = "󰌾 ";
      };

      git_branch = {
        disabled = false;
        style = "fg:bold black bg:purple";
        format = "[$symbol $branch(:$remote_branch)]($style)";
        symbol = "󰘬";
      };

      dotnet = {
        style = "fg:bold black bg:blue";
        format = "[$symbol $version]($style)";
        symbol = "";
      };

      character = {
        success_symbol = "[✔](bold green)";
        error_symbol = "[✗](bold red)";
      };

    };
  };
}
