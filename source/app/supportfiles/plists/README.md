### Important setup

This point, you should duplicate and rename the `Info.plist` file  to `dev.info.plist` name, and provide the API Key, updating the value of `API_MARVEL_PRIVATE_KEY` and `API_MARVEL_PUBLIC_KEY` keys with your production keys, into Info.plist and development keys into dev.info.plist file.

Info.plist
``` swift
"API_MARVEL_PRIVATE_KEY"="API_KEY_PRIVATE_PRODUCTION_VALUE"
"API_MARVEL_PUBLIC_KEY"="API_KEY_PUBLIC_PRODUCTION_VALUE"
```
dev.info.plist
``` swift
"API_MARVEL_PRIVATE_KEY"="API_KEY_PRIVATE_DEVELOPMENT_VALUE"
"API_MARVEL_PUBLIC_KEY"="API_KEY_PUBLIC_DEVELOPMENT_VALUE""
```

### Observation

 The dev.info.plist file is not tracked by git history. So, do you should provider yours.