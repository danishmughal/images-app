class UploadsController < ApplicationController
  before_action :set_upload, only: [:show, :edit, :update, :destroy]
 
  # GET /uploads
  def index
    @uploads = Upload.all
  end
 
  # GET /uploads/1
  def show
    # image1 = open('https://s3-us-west-1.amazonaws.com/image-similarity-app/uploads/upload/name/1/tree-02.png')
    # IO.copy_stream(image1, 'temp-images/image1.png')

    # image2 = open('https://s3-us-west-1.amazonaws.com/image-similarity-app/uploads/upload/name/2/tree.jpg')
    # IO.copy_stream(image2, 'temp-images/image2.jpg')

    # img1 = Phashion::Image.new('temp-images/image1.png')
    # img2 = Phashion::Image.new('temp-images/image2.jpg')

    # puts img1.distance_from(img2)
  end
 
  # GET /uploads/new
  def new
    @upload = Upload.new
  end
 
  # GET /uploads/1/edit
  def edit
  end
 
  # POST /uploads
  def create
    @upload = Upload.new(post_upload_params)
 
    if @upload.save
      @upload.phash!
      @upload.save
      redirect_to @upload, notice: 'Upload was successfully created.'
    else
      throw ''
      render :new
    end
  end

  def matched_uploads
    image = open(params["name"])
    IO.copy_stream(image, 'temp-images/image.jpg')
    @phash_image = Phashion::Image.new('temp-images/image.jpg')

    

    @uploads = Upload.all.sort_by { |upload| (upload.fingerprint.to_i(16) ^ @phash_image.fingerprint).to_s(2).count("1") }
  end
 
  # PATCH/PUT /uploads/1
  def update
    if @upload.update(post_upload_params)
      redirect_to @upload, notice: 'Upload attachment was successfully updated.'
    else
      render :edit
    end
  end
 
  # DELETE /uploads/1
  def destroy
    @upload.destroy
    redirect_to uploads_url, notice: 'Upload was successfully destroyed.'
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:id])
    end
 
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_upload_params
      params.require(:upload).permit(:name)
    end
end
