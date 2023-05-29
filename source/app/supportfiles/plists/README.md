### Important setup

This point, you should duplicate and rename the `Info.plist` file  to `dev.info.plist` name, and provide the API Key, updating the value of `API_KEY_MARVEL` key with your production key, into Info.plist and development key into dev.info.plist file.

Info.plist
``` swift
"API_KEY_MARVEL"="API_KEY_PRODUCTION_VALUE"
```
dev.info.plist
``` swift
"API_KEY_MARVEL"="API_KEY_DEVELOPMENT_VALUE"
```

### Observation

 The dev.info.plist file is not tracked by git history. So, do you should provider yours.