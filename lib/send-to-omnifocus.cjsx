{React, Actions, Message, DraftStore, ContactStore, AccountStore, DatabaseStore} = require 'nylas-exports'

mailDropSuffix = "@sync.omnigroup.com"

class SendToOmnifocus extends React.Component
  @displayName: "SendToOmnifocus"

  constructor: (@props) ->
    ContactStore.searchContacts(mailDropSuffix).then (contacts) =>
      return if contacts.length != 1
      @omnifocusContact = contacts[0]
      @forceUpdate()

  handleClick: =>
    gmailLink = @gmailLink()
    [_, ..., lastMessage] = @thread().metadata
    message = new Message
      draft: true
      to: [@omnifocusContact]
      from: [@account().defaultMe()]
      subject: @thread().subject
      body: "<a href='#{gmailLink}'>#{gmailLink}</a><br><br>#{lastMessage.snippet}"

    DatabaseStore.inTransaction (t) =>
      t.persistModel(message)
    .then =>
      Actions.composePopoutDraft(message.clientId)

  thread: =>
    @props.thread

  subject: =>
    @thread().subject

  gmailLink: =>
    email = @account().emailAddress
    "https://mail.google.com/mail/u/#{email}/#search/#{encodeURIComponent(@thread().subject)}"

  account: =>
    AccountStore.accountForItems([@thread()])

  render: =>
    return <span></span> unless @omnifocusContact?

    <div>
      <button title="Send to Omnifocus" className="btn btn-toolbar" onClick={this.handleClick}>
        Omnifocus
      </button>
    </div>

module.exports = SendToOmnifocus
