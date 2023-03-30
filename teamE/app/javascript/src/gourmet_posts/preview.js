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
      const template = document.querySelector('#preview-template');
      const clone = template.content.cloneNode(true);
      const image = clone.querySelector("img");
      image.src = fileReader.result

      preview.appendChild(clone)
    }
    fileReader.readAsDataURL(file)
  }
}

