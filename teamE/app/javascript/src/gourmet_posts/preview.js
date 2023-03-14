previewImage = (event) => {
  console.log(event.target.files)
  const files = []
  const preview = document.getElementById('preview')
  preview.innerHTML = ''

  if (event.target.files.length > 1) {
    for (let i = 0; i < event.target.files.length; i++) {
      files.push(event.target.files[i])
    }
  } else {
    files.push(event.target.files[0])
  }

  for (let i = 0; i < files.length; i++) {
    const file = files[i]
    const fileReader = new FileReader()
    fileReader.onload = () => {
      const image = document.createElement('img')

      image.src = fileReader.result
      preview.appendChild(image)
    }
    fileReader.readAsDataURL(file)
  }
}

