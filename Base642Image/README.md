## About
Allows you to encode images with Base64 to exfiltrate them easily. You can also decode the Base64 files to get your image back.

## Usage
### Encode an image to Base64
`img-b64 -img "C:\Users\You\Pictures\photo.png"`

### Encode and save to Temp folder instead
`img-b64 -img "C:\Users\You\Pictures\photo.png" -location temp`

### Decode a Base64 string back to an image
`b64-img -file "$env:USERPROFILE\Desktop\encImage.txt"`

### Decode and save to Temp folder
`b64-img -file "$env:TMP\encImage.txt" -location temp`
