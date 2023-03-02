previewImage = (event) => {
  const file = event.target.files[0];

  const fileReader = new FileReader();
  fileReader.onload = () => {
    const preview = document.getElementById('preview');
    preview.src = fileReader.result;
  };
  fileReader.readAsDataURL(file);
};
