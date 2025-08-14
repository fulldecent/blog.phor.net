import fs from "fs";
import jsdom from "jsdom";

// Retrieve arguments passed from the command line, excluding the first two (node executable and script path)
const args = process.argv.slice(2);

// Get the script name from the file path
const scriptName = process.argv[1].split("/").pop();

// Check usage
if (args.length === 0) {
  console.log(`Usage: ${scriptName} file ...`);
  process.exit(1);
}

// Process each file
args.forEach((file) => {
  console.log(`- ${file}`);
  const dom = new jsdom.JSDOM(fs.readFileSync(file, "utf8"));

  // Title
  const title = dom.window.document.querySelector("title");
  console.log(`  - TITLE: ${title.textContent}`);

  // Headings
  const headings = dom.window.document.querySelectorAll("h1, h2, h3, h4, h5, h6");
  for (const heading of headings) {
    const spaces = "  ".repeat(heading.tagName[1]);
    const headingText = heading.textContent.replace(/\s+/g, " ").trim();
    console.log(`${spaces}- ${heading.tagName}: ${headingText}`);
  }
});
