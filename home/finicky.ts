import type {
  BrowserHandler,
  FinickyConfig,
} from "/Applications/Finicky.app/Contents/Resources/finicky.d.ts";

const WORK_BROWSER = "Google Chrome";
const PERSONAL_BROWSER = "Brave Browser";

const workHandler: BrowserHandler = {
  match: (url: URL, { opener }) => {
    const workDomains = [
      "airtm.slack.com",
      "airtech.awsapps.com",
      "docs.google.com",
      "airtech.atlassian.net",
    ];
    return (
      url.host.includes("airtech") ||
      workDomains.some((domain) => url.host.includes(domain))
    );
  },
  browser: WORK_BROWSER,
};

const personalHandler: BrowserHandler = {
  match: (url: URL, { opener }) => {
    const personalDomains = ["x.com/*", "*instagram.com/*", "*.gov.br*"];
    return personalDomains.some((domain) => url.host.includes(domain));
  },
  browser: PERSONAL_BROWSER,
};

export default {
  defaultBrowser: PERSONAL_BROWSER,
  rewrite: [],
  handlers: [workHandler, personalHandler],
} satisfies FinickyConfig;
