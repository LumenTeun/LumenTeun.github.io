const THEMES = ["salmon", "lime", "dust"];

function setThemeRandomly() {
  const oldClassName = document.body.className;
  document.body.className = THEMES[Math.floor(Math.random() * THEMES.length)];
  if (oldClassName == document.body.className) {
    setThemeRandomly();
  }
}

document
  .querySelector("#discoball")
  .addEventListener("click", setThemeRandomly);

setThemeRandomly();
