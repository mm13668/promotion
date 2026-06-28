package request

type UpdateContactMessageProcessedReq struct {
	ID          uint `json:"id"`
	IsProcessed bool `json:"isProcessed"`
}
