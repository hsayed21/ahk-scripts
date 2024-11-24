class URLParser {
	Protocol := ""
	Domain := ""
	Port := ""
	Path := ""
	Query := ""
	Hash := ""
	Username := ""
	Password := ""

	__New(url) {
		this.ParseURL(url)
	}

	ParseURL(url) {
		regex := "^(?<Protocol>https?|ftp)://(?:(?<Username>[^:]+)(?::(?<Password>[^@]+))?@)?(?<Domain>(?:[\w-]+\.)+\w\w+)(?::(?<Port>\d+))?/?(?<Path>(?:[^/?# ]*/?)+)?(?:\?(?<Query>[^#]+)?)?(?:#(?<Hash>.+)?)?$"

		if (RegExMatch(url, regex, &match)) {
			this.Protocol := match.Protocol
			this.Username := match.Username
			this.Password := match.Password
			this.Domain := match.Domain
			this.Port := match.Port
			this.Path := match.Path
			this.Query := match.Query
			this.Hash := match.Hash
		}
	}
}

; Usage:
; url := "https://www.google.com/search?q=github"
; parser := URLParser(url)
; MsgBox(parser.Protocol) ; Output: http
; MsgBox(parser.Domain) ; Output: www.google.com
; MsgBox(parser.Query) ; Output: q=github
