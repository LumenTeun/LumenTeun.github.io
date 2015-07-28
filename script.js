var shellPrompt = "~ ";

var abouts = [
  "facebook",
   "twitter",
    "github",
      "xmpp",
      "mail",
       "pgp"
];

var commands = {
      "help": help,
     "about": about,
     "clear": clear
}

function echo(output) {
  stdout.innerHTML = stdout.innerHTML + output + "<br>";
}

function about(what) {
  switch(what) {
    case "facebook":
      echo("Hahahaha... ha.. yeah.");
      break;

    case "twitter":
      echo("Tweet tweet!<br>Sometimes I use <a href='https://twitter.com/ahstro_' target='_blank'>Twitter</a> as a noise-to-void machine instead of a source of news.");
      break;

    case "github":
      echo("Open source is tha b0mb!<br>Find the source for this site and (almost) everything else I've ever made at <a href='https://twitter.com/ahstro_' target='_blank'>GitHub</a>.");
      break;

    case "xmpp":
      echo("Want to chat with me using \"rock-solid Internet standards\", losing half the messages trying to figure OTR out?<br>Add me on XMPP/Jabber with <a href='xmpp:ahstro@dukgo.com'>ahstro@dukgo.com</a>");
      break;

    case "mail":
      echo("You know that thing you use to register social media accounts and receive spam about penis enlargement pills and Google? You can actually use it to send messages as well.<br>My e-mail address is <a href='mailto:anton@lutic.org'>anton@lutic.org</a>");
      break;

    case "pgp":
      echo("\"Encryption is overrated, right?\" - Everyone<br>My PGP-key is 0x50a3573efbfa9867, grab it from <a href='https://pgp.mit.edu/pks/lookup?op=vindex&search=0x50A3573EFBFA9867' traget='_blank'>MIT's keyserver</a>.");
      break;

    default:
      echo("My name's Anton and I write code; welcome to my website.");
      break;
  }
}

function clear() {
  stdout.innerHTML = "";
}

function help() {
  echo("The available commands are:");
  Object.keys(commands).concat(abouts).forEach(function(command) {
    echo(command);

  });
}

function complete(uncompleted) {
  if(uncompleted !== "") {
    Object.keys(commands).concat(abouts).forEach(function(command) {
      if(command.indexOf(uncompleted) === 0) stdin.value = command;
    });
  }
}

function execute(command) {
  stdin.value = "";
  echo(shellPrompt + command);
  if(commands[command]) {
    commands[command]();
  } else if(abouts.indexOf(command) !== -1) {
    about(command);
  } else if(command) {
    echo("ash: command not found: " + command + "<br>try 'help' if you're lost");
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

      case 9:
        complete(stdin.value);
        break;

    }
  });

  terminal.addEventListener("click", function(event) {
    stdin.focus();
  });
});
