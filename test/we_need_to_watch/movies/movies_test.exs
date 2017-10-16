defmodule WeNeedToWatch.MoviesTest do
  use WeNeedToWatch.DataCase

  alias WeNeedToWatch.Movies

  describe "titles" do
    alias WeNeedToWatch.Movies.Movie

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def title_fixture(attrs \\ %{}) do
      {:ok, title} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Movies.create_title()

      title
    end

    test "list_titles/0 returns all titles" do
      title = title_fixture()
      assert Movies.list_titles() == [title]
    end

    test "get_title!/1 returns the title with given id" do
      title = title_fixture()
      assert Movies.get_title!(title.id) == title
    end

    test "create_title/1 with valid data creates a title" do
      assert {:ok, %Title{} = title} = Movies.create_title(@valid_attrs)
      assert title.title == "some title"
    end

    test "create_title/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Movies.create_title(@invalid_attrs)
    end

    test "update_title/2 with valid data updates the title" do
      title = title_fixture()
      assert {:ok, title} = Movies.update_title(title, @update_attrs)
      assert %Title{} = title
      assert title.title == "some updated title"
    end

    test "update_title/2 with invalid data returns error changeset" do
      title = title_fixture()
      assert {:error, %Ecto.Changeset{}} = Movies.update_title(title, @invalid_attrs)
      assert title == Movies.get_title!(title.id)
    end

    test "delete_title/1 deletes the title" do
      title = title_fixture()
      assert {:ok, %Title{}} = Movies.delete_title(title)
      assert_raise Ecto.NoResultsError, fn -> Movies.get_title!(title.id) end
    end

    test "change_title/1 returns a title changeset" do
      title = title_fixture()
      assert %Ecto.Changeset{} = Movies.change_title(title)
    end
  end
end
