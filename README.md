Fields :

# visit to the page
visit 'path'


# fill the input field
fill_in 'id', with: 'value'


# click the button
click_button 'Sign In'


# select
select 'Value', from: :select_id


# checkbox
check("Label")
or
find("#pickem_option_ids_10").check

# radio
choose('registration_payer_type_freelancer') # id
choose('registration[payer_type]', option: 'freelancer') # name and value to make unique
choose('Freelancer') # label text
choose(option: 'freelancer') # just value if the only radio button with that value
find(:xpath, './/input[@value="freelancer"]').click

# upload the file
find(".upload_field").attach_file(:user_uploads, 'spec/fixtures/test.png')

Confirm :

# dismiss the confirm

page.dismiss_confirm do
  click_button 'button'
end

# accept the confirm
page.accept_confirm do
  click_button 'Delete Contact'
end

Helpers :

have_content
have_field
have_link
have_button
have_css
have_text