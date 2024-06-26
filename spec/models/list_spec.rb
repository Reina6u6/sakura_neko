# frozen_string_literal: true

require 'rails_helper'

describe　'投稿のテスト'
 let!(:post_image) { create(:post_image,title:'title',body:'body',image:'image') }
 describe 'トップ画面(root_path)のテスト' do
    visit root_path
   end
   context '表示の確認' do
     it 'トップ画面(root_path)に投稿一覧やログインのリンクが表示されているか' do
       expect(page).to have_link "", href: postimages_path
     end
     it 'root_pathが"/"であるか' do
       expect(current_path).to eq('/')
     end
   end

  describe　'投稿一覧のテスト' do
    before do
      visit postimages_path
    end
    context '一覧の表示とリンクの確認' do
      it "bookの一覧表示(tableタグ)と投稿フォームへのリンクが同一画面に表示されているか" do
        expect(page).to have_selector 'table'
        expect(page).to have_field 'post_image[title]'
        expect(page).to have_field 'Post_image[image]'
        expect(page).to have_field 'Post_image[body]'
        expect(page).to have_field 'Post_image[tag]'
      end
      it "post_imageのタイトル、ユーザーネーム、本文、タグ、コメント数を表示し、詳細とコメント数のリンクが表示されているか" do
        (1..5).each do |i|
           Postimage.create(title:'tittle'+i.to_s,body:'body'+i.to_s)
         end
         visit postimages_path
         Post_image.all.each_with_index do |post_image,i|
           j = i *3
           expect(page).to have_content post_image.title
           expect(page).to have_content post_image.body

           #詳細リンク
           show_link = find_all('a')[j]
           expect(show_link.native.inner_text).to match(/show/i)
           expect(show_link[:href]).to eq post_image_path(post_image)

           #編集リンク
           show_link = find_all('a')[j+1]
           expect(show_link.native.inner_text).to match(/edit/i)
           expect(show_link[:href]).to eq edit_post_image_path(post_image)

           #削除リンク
           show_link = find_all('a')[j+2]
           expect(show_link.native.inner_text).to match(/destroy/i)
           expect(show_link[:href]).to eq post_image_path(post_image)
          end
        end
        it '送信ボタンが表示される' do
          expect(page).to have_button '送信する'
        end
      end
      context '投稿後のリダイレクト先は正しいか' do
         fill_in 'post_image[title]', with: Faker::Lorem.characters(number:5)
         fill_in 'post_image[body]', with: Faker::Lorem.characters(number:20)
         click_button '送信する'
         expect(page).to have_current_path post_image_path(Post_image.last)
        end
      end

       describe '詳細画面のテスト' do
         before do
           visit post_image_path(post_image)
         end
         context '表示の確認' do
           it '投稿のタイトルと投稿画像、タイトルが画面に表示されていること' do
             expect(page).to have_content post_image.title
             expect(page).to have_content post_image.body
             expect(page).to have_content post_image.image
          end
          
          context 'リンクの遷移先の確認' do
            it 'プロフィール編集の遷移先は編集画面であるか' do
              edit_link = find_all('a')[0]
              edit_link.click
              expect(current_path).to eq('/post_images/' + post_imagek.id.to_s + '/edit')
            end
            
           




