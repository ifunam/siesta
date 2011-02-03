class FileUploadersController <  UserResourcesController
  defaults :resource_class => UserDocument, :collection_name => 'documents', :instance_name => 'document'
end
