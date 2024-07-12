package api

import (
	"github.com/Hain2000/simplebank/util"
	"github.com/go-playground/validator/v10"
)

var validCurrency validator.Func = func(fl validator.FieldLevel) bool {
	if currecny, ok := fl.Field().Interface().(string); ok {
		return util.IsSupportedCurrency(currecny)
	}
	return false
}