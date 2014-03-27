require 'spec_helper'

describe "Creating to do list" do
	it "redirect to the todo_list index page on success" do	
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: "My todo list"
		fill_in "Description", with: "This is what I'm doing today"
		click_button "Create Todo list"

		expect(page).to have_content("My todo list")
	end

	it "display an error when todo list has title less than 3 characters" do
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: "Hi"
		fill_in "Description", with: "This is what I'm doing today"
		click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today")
	end

	it "display an error when todo list has no description" do
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: "Grocery List"
		fill_in "Description", with: ""
		click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Grocery List")
	end

	it "display an error when todo list has description less than 5 characters" do
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: "Grocery List"
		fill_in "Description", with: "Food"
		click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Grocery List")
	end
end