{React, Actions, DraftStore, ContactStore, AccountStore} = require 'nylas-exports'

mailDropSuffix = "@sync.omnigroup.com"

class SendToOmnifocus extends React.Component
  @displayName: "SendToOmnifocus"

  constructor: (@props) ->
    ContactStore.searchContacts(mailDropSuffix).then (contacts) =>
      return if contacts.length != 1
      @omnifocusContact = contacts[0]
      @forceUpdate()

  handleClick: =>
    unsubscribe = DraftStore.listen (draft) =>
      mail = draft.objects[0]
      link = @gmailLink()
      mail.to = [@omnifocusContact]
      mail.body = "<a href='#{link}'>#{link}</a><br><br>#{mail.body}"
      unsubscribe()

    Actions.composeForward(threadId: @thread().serverId)

  thread: =>
    @props.thread

  subject: =>
    @thread().subject

  gmailLink: =>
    email = AccountStore.accountForItems([@thread()]).emailAddress
    "https://mail.google.com/mail/u/#{email}/#search/#{encodeURIComponent(@thread().subject)}"

  render: =>
    return <span></span> unless @omnifocusContact?

    <div>
      <button title="Send to Omnifocus" className="btn btn-toolbar" onClick={this.handleClick}>
        Omnifocus
      </button>
    </div>

module.exports = SendToOmnifocus
