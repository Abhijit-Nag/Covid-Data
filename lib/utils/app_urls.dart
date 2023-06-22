

class AppUrl{
//this is our base api
static const String baseUrl = "https://disease.sh/v3/covid-19/";

//fetch world covid states
static const String worldStatesAPI = '${baseUrl}all';
static const String countriesList = '${baseUrl}countries';
}