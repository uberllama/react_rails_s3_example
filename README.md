Companion code to my blog post on uploading to S3 with React, Rails, and Paperclip.

<http://blog.littleblimp.com/post/119230396893/direct-uploads-to-s3-with-react-rails-and-paperclip>

Do it:

1. Clone
2. Update config/secrets.yml with your AWS credentials
3. `bundle`
4. `rake db:create && rake db:migrate`
5. `rails s` in one terminal and `rake jobs:work` in another
6. <http://localhost:3000>

