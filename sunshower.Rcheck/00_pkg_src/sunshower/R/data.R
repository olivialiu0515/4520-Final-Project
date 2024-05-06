
#' Daily Weather Data from Stations across United States
#'
#' A dataset comprising daily weather observations from weather stations in the US.
#' The dataset includes various meteorological measurements collected over several years.
#'
#' @format A data frame with observations on the following 10 variables:
#' \describe{
#'   \item{WBANNO}{\code{integer} The weather station WBAN number}
#'   \item{state_name}{\code{character} The state where the station is located}
#'   \item{station_name}{\code{character} The name of the station}
#'   \item{LST_DATE}{\code{integer} The date of observation in YYYYMMDD format}
#'   \item{CRX_VN}{\code{numeric} Version number of the data}
#'   \item{LONGITUDE}{\code{numeric} Longitude of the weather station}
#'   \item{LATITUDE}{\code{numeric} Latitude of the weather station}
#'   \item{T_DAILY_MAX}{\code{numeric} Maximum daily temperature in degrees Celsius, missing values are marked as \code{NA}}
#'   \item{T_DAILY_MIN}{\code{numeric} Minimum daily temperature in degrees Celsius, missing values are marked as \code{NA}}
#'   \item{T_DAILY_AVG}{\code{numeric} Average daily temperature in degrees Celsius, missing values are marked as \code{NA}}
#'   \item{P_DAILY_CALC}{\code{numeric} Calculated daily precipitation in millimeters, missing values are marked as \code{NA}}
#'   \item{SOLARAD_DAILY}{\code{numeric} Daily solar radiation in MJ/m^2, missing values are marked as \code{NA}}
#' }
#' @keywords internal
#' @name all_daily_data
NULL
