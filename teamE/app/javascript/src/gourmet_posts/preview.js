const files = []

previewImage = (event) => {
  const preview = document.getElementById('preview')
  preview.innerHTML = ''

  files.push(event.target.files[0])

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
