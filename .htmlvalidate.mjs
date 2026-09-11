import { defineConfig } from "html-validate";
import NiceCheckersPlugin from "@fulldecent/nice-checkers-plugin";

export default defineConfig({
  plugins: [NiceCheckersPlugin],
  extends: ["html-validate:prettier", "nice-checkers-plugin:recommended"],
  rules: {
    "allowed-links": [
      "error",
      {
        allowExternal: {
          exclude: ["\\\\?utm_source=chatgpt.com"],
        },
        allowRelative: {
          // Literal ".htm"/".html" only. An unescaped "." also matches slugs
          // that end in "-html" (e.g. /convert-fen-strings-to-html).
          exclude: ["\\.html?$"],
        },
        allowAbsolute: {
          exclude: ["\\.html?$"],
        },
      },
    ],
    "nice-checkers/external-links": [
      "error",
      {
        skipRegexes: [
          "dont-check-this.example.com",
          // GitHub "Edit this page" always redirects anonymous checkers to /login
          "github\\.com/.*/edit/",
          "github\\.com/login",
        ],
        urlRewrites: [{ pattern: "^https://blog\\.phor\\.net", replacement: "./build" }],
        alternativeExtensions: [".html"],
        indexFile: "index.html",
      },
    ],
    "nice-checkers/internal-links": [
      "error",
      {
        webRoot: "./build",
        alternativeExtensions: [".html"],
        indexFile: "index.html",
      },
    ],
    "nice-checkers/alternate-language-links": [
      "error",
      {
        urlRewrites: [{ pattern: "^https://blog\\.phor\\.net", replacement: "./build" }],
      },
    ],
    "wcag/h37": [
      "error",
      {
        allowEmpty: false,
        alias: [],
      },
    ],
    // TODO: cut this over to "error" once remaining PNG/JPEG/GIF/MP3 (and other dirty
    // asset paths) are converted to WebP/SVG/WebM. Not enforced on this site yet.
    "nice-checkers/match-regex": [
      "warn",
      {
        mustNotMatch: ["\\.(?:png|jpe?g|gif|woff|eot|ttf|htm|ogv|mp4|mp3)(?:[\"'?#]|$)"],
      },
    ],
  },
});
