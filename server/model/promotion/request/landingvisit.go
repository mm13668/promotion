package request

type LandingVisitDurationReport struct {
	Id          uint `json:"id" form:"id"`
	AddDuration int  `json:"addDuration" form:"addDuration"`
}

type LandingVisitCopyReport struct {
	Id              uint   `json:"id" form:"id"`
	ServicePhone    string `json:"servicePhone" form:"servicePhone"`
	ServiceNickname string `json:"serviceNickname" form:"serviceNickname"`
}
