import type {
  BrowserHandler,
  FinickyConfig,
} from "/Applications/Finicky.app/Contents/Resources/finicky.d.ts";

const handler: BrowserHandler = {
  match: (url: URL, { opener }) => {
    return url.host.includes("airtech");
  },
  browser: "Google Chrome",
};

export default {
  defaultBrowser: "Google Chrome",

  rewrite: [],

  handlers: [
    handler,

    // Airtm
    { match: "airtm.slack.com/*", browser: "Google Chrome" },
    { match: "airtech.awsapps.com/*", browser: "Google Chrome" },
    { match: "docs.google.com/*", browser: "Google Chrome" },
    { match: "airtech.atlassian.net/*", browser: "Google Chrome" },

    // Personal
    { match: "x.com/*", browser: "Brave Browser" },
    { match: "*instagram.com/*", browser: "Brave Browser" },

    // Example with args
    // {
    //   match: "",
    //   browser: (url, options) => ({
    //     name: "Brave Browser",
    //     args: ["-n", "--args", "--incognito", "--profile-directory=Profile 3", url.href],
    //   }),
    // },
  ],
} satisfies FinickyConfig;
