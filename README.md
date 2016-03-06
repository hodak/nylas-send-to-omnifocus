# nylas-send-to-omnifocus

Small plugin that adds button in toolbar to send e-mail to Omnifocus' inbox, using its [MailDrop](https://support.omnigroup.com/omnifocus-mail-drop/) feature.

Bonus value when you use Gmail - it will include a link to search for the e-mail by subject (unfortunately, I haven't found a way to link directly to the e-mail - if you have any idea how to do it please let me know).

![](doc/nylas-send-to-omnifocus.gif?raw=true)

## Setup

1. Set up Mail Drop address: [https://manage.sync.omnigroup.com/manage/](https://manage.sync.omnigroup.com/manage/). It should have `@sync.omnigroup.com` suffix.
2. Add your Mail Drop address to your contacts in your e-mail.
3. Install plugin:

```
$ git clone https://github.com/hodak/nylas-send-to-omnifocus.git ~/.nylas/packages/nylas-send-to-omnifocus
```

4. Restart Nylas. Make sure e-mail (and contacts) are synced, otherwise `Omnifocus` button won't show up.

**Important**: plugin won't work if there will be more than 1 e-mail address in your contacts in this domain: `sync.omnigroup.com`

## Troubleshooting

If `Omnifocus` button doesn't show up, make sure you have exactly 1 contact in `sync.omnigroup.com` domain. You can do it by opening developer tools: **Developer > Toggle Developer Tools** and pasting this code:

```
require("nylas-exports").ContactStore.searchContacts("@sync.omnigroup.com").then(function(contacts) { console.log(contacts) }); ""
```

It should print:

```
""
► [Contact]
```

[See video](https://v.usetapes.com/rUIVNiVH2j)
