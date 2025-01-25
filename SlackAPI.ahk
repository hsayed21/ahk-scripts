/******************************************
 * @file SlackAPI.ahk
 * @description: A class to interact with Slack API
 * @author hsayed
 * @date 2025/01/25
 * @version 1.0.0
 *******************************************/

class SlackAPI {
	baseUrl := "https://slack.com/api"
	token := ""

	__New(token) {
		this.token := token
	}

	SendRequest(endpoint, payload) {
		http := ComObject("WinHttp.WinHttpRequest.5.1")
		http.Open("POST", this.baseUrl "/" endpoint, true)
		http.SetRequestHeader("Authorization", "Bearer " this.token)
		http.SetRequestHeader("Content-Type", "application/json; charset=utf-8")
		http.Send(payload)
		http.WaitForResponse()
	}

	SetStatus(text, emoji) {
		payload := '{"profile":{"status_text":"' text '","status_emoji":"' emoji '"}}'
		this.SendRequest("users.profile.set", payload)
	}

	SetPresence(presence) {
		payload := '{"presence":"' presence '"}'
		this.SendRequest("users.setPresence", payload)
	}

	PauseNotifications(minutes) {
		payload := '{"num_minutes":' minutes '}'
		this.SendRequest("dnd.setSnooze", payload)
	}

	ResumeNotifications() {
		this.SendRequest("dnd.endSnooze", "{}")
	}
}