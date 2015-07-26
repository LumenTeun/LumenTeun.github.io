var shellPrompt = "~ ";

var commands = {
  "clear": clear,
   "help": help
}

function echo(output) {
  stdout.innerHTML = stdout.innerHTML + output + "<br>";
}

function clear() {
  stdout.innerHTML = "";
}

function help() {
  echo("The available commands are:");
  Object.keys(commands).forEach(function(command) {
    echo(command);
  });
}

function execute(command) {
  stdin.value = "";
  echo(shellPrompt + command);
  if(commands[command]) {
    commands[command]();
  } else if (command) {
    echo("ash: command not found: " + command);
  }
}

document.addEventListener("DOMContentLoaded", function(event) {
  stdin.addEventListener("keydown", function(event) {
    switch(event.keyCode) {
      case 13:
        execute(stdin.value);
        break;

      case 76:
        if(event.ctrlKey) clear();
        break;
    }
  });

  terminal.addEventListener("click", function(event) {
    stdin.focus();
  });
});
