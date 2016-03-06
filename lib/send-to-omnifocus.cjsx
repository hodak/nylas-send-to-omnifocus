{React, MessageStore} = require 'nylas-exports'

class SendToOmnifocus extends React.Component
  @displayName: "SendToOmnifocus"

  constructor: (@props) ->

  handleClick: =>
    console.log("Subject: #{@subject()}")

  subject: =>
    @props.thread.subject

  render: =>
    <div>
      <button className="btn btn-toolbar" onClick={this.handleClick}>
        O
      </button>
    </div>

module.exports = SendToOmnifocus
