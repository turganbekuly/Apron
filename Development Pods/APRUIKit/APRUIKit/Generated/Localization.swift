// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum AddComment {
    public enum ChooseRightEmoji {
      /// Пожалуйста, выберите подходящий смайлик
      public static let title = L10n.tr("APRLocalizable", "AddComment.ChooseRightEmoji.Title")
    }
    public enum FillAllFields {
      /// Пожалуйста, заполните поля!
      public static let title = L10n.tr("APRLocalizable", "AddComment.FillAllFields.Title")
    }
    public enum HowDidItTaste {
      /// Как это было на вкус?
      public static let title = L10n.tr("APRLocalizable", "AddComment.HowDidItTaste.Title")
    }
    public enum MakeItAgain {
      /// Приготовили бы снова?
      public static let title = L10n.tr("APRLocalizable", "AddComment.MakeItAgain.Title")
    }
    public enum Note {
      /// Расскажите о своем опыте. Любые советы по улучшению этого рецепта?
      public static let placeholder = L10n.tr("APRLocalizable", "AddComment.Note.Placeholder")
    }
    public enum SendMessageError {
      /// Произошла ошибка при отправке, пожалуйста, попробуйте позднее
      public static let title = L10n.tr("APRLocalizable", "AddComment.SendMessageError.Title")
    }
    public enum WhatWasGood {
      /// Что в нем было хорошего?
      public static let title = L10n.tr("APRLocalizable", "AddComment.WhatWasGood.Title")
    }
  }

  public enum AddSavedRecipes {
    public enum AddRecipe {
      /// Добавить рецепт
      public static let title = L10n.tr("APRLocalizable", "AddSavedRecipes.AddRecipe.Title")
    }
    public enum SearchFavoriteRecipes {
      /// Поиск рецептов в избранном
      public static let title = L10n.tr("APRLocalizable", "AddSavedRecipes.SearchFavoriteRecipes.Title")
    }
  }

  public enum Alert {
    /// Произошла ошибка! Пожалуйста, попробуйте позднее
    public static let errorMessage = L10n.tr("APRLocalizable", "Alert.ErrorMessage")
    public enum Attention {
      /// Внимание!
      public static let title = L10n.tr("APRLocalizable", "Alert.Attention.Title")
    }
    public enum Authorization {
      public enum Skip {
        /// Вы пропустите персонализированный контент и сохранение наших вкусных рецептов.
        public static let message = L10n.tr("APRLocalizable", "Alert.Authorization.Skip.Message")
        /// Вы действительно хотите пропустить?
        public static let title = L10n.tr("APRLocalizable", "Alert.Authorization.Skip.Title")
      }
    }
    public enum Clear {
      /// Понятно
      public static let buttonTitle = L10n.tr("APRLocalizable", "Alert.Clear.ButtonTitle")
    }
    public enum NameExists {
      /// Такое имя уже существует, пожалуйста, введите другое
      public static let message = L10n.tr("APRLocalizable", "Alert.NameExists.Message")
    }
    public enum RecipeCreation {
      /// К сожалению, содание рецептов на данный момент недоступно. Администратор приложения временно отключил эту функцию.
      public static let error = L10n.tr("APRLocalizable", "Alert.RecipeCreation.Error")
    }
    public enum Sad {
      /// Жаль
      public static let buttonTitle = L10n.tr("APRLocalizable", "Alert.Sad.ButtonTitle")
    }
  }

  public enum Authorization {
    public enum Button {
      public enum SignIn {
        /// У вас уже есть аккаунт?  
        public static let disclaimer = L10n.tr("APRLocalizable", "Authorization.Button.SignIn.Disclaimer")
        /// Войти
        public static let title = L10n.tr("APRLocalizable", "Authorization.Button.SignIn.Title")
      }
      public enum SignUp {
        /// Регистрация
        public static let title = L10n.tr("APRLocalizable", "Authorization.Button.SignUp.Title")
      }
    }
    public enum ConfirmPassword {
      /// Подтвердите пароль
      public static let tfTitle = L10n.tr("APRLocalizable", "Authorization.ConfirmPassword.TFTitle")
    }
    public enum Email {
      /// mymail@gmail.com
      public static let tfPlaceholder = L10n.tr("APRLocalizable", "Authorization.Email.TFPlaceholder")
      /// Эл.почта
      public static let tfTitle = L10n.tr("APRLocalizable", "Authorization.Email.TFTitle")
    }
    public enum Navigation {
      /// Вход
      public static let title = L10n.tr("APRLocalizable", "Authorization.Navigation.Title")
    }
    public enum Password {
      /// ***********
      public static let tfPlaceholder = L10n.tr("APRLocalizable", "Authorization.Password.TFPlaceholder")
      /// Пароль
      public static let tfTitle = L10n.tr("APRLocalizable", "Authorization.Password.TFTitle")
    }
    public enum SignIn {
      /// С возвращением!
      public static let title = L10n.tr("APRLocalizable", "Authorization.SignIn.Title")
    }
    public enum SignUp {
      /// Регистрация в Apron
      public static let title = L10n.tr("APRLocalizable", "Authorization.SignUp.Title")
      public enum Error {
        /// Не удалось зарегистрироваться. Пожалуйста, попробуйте позднее!
        public static let title = L10n.tr("APRLocalizable", "Authorization.SignUp.Error.Title")
      }
    }
    public enum Skip {
      /// Вы пропустите персонализированный контент и сохранение наших вкусных рецептов.
      public static let message = L10n.tr("APRLocalizable", "Authorization.Skip.Message")
      /// Вы действительно хотите пропустить?
      public static let title = L10n.tr("APRLocalizable", "Authorization.Skip.Title")
    }
    public enum Username {
      /// Сохранить
      public static let buttonTitle = L10n.tr("APRLocalizable", "Authorization.Username.ButtonTitle")
      /// Заполните ваше имя для продолжения
      public static let subtitle = L10n.tr("APRLocalizable", "Authorization.Username.Subtitle")
      /// Имя
      public static let tfPlaceholder = L10n.tr("APRLocalizable", "Authorization.Username.TFPlaceholder")
      /// Имя пользователя
      public static let tfTitle = L10n.tr("APRLocalizable", "Authorization.Username.TFTitle")
      /// Привет!
      public static let title = L10n.tr("APRLocalizable", "Authorization.Username.Title")
    }
  }

  public enum Common {
    /// Все
    public static let all = L10n.tr("APRLocalizable", "Common.All")
    /// Отмена
    public static let cancel = L10n.tr("APRLocalizable", "Common.Cancel")
    /// Закрыть
    public static let close = L10n.tr("APRLocalizable", "Common.Close")
    /// Фильтры
    public static let filters = L10n.tr("APRLocalizable", "Common.Filters")
    /// Нет
    public static let no = L10n.tr("APRLocalizable", "Common.No")
    /// Предпросмотр
    public static let preview = L10n.tr("APRLocalizable", "Common.Preview")
    /// Да
    public static let yes = L10n.tr("APRLocalizable", "Common.Yes")
    /// Отменить
    public static let сancelTwo = L10n.tr("APRLocalizable", "Common.СancelTwo")
    public enum Add {
      /// Добавить
      public static let title = L10n.tr("APRLocalizable", "Common.Add.Title")
    }
    public enum AddReview {
      /// Добавить отзыв
      public static let title = L10n.tr("APRLocalizable", "Common.AddReview.Title")
    }
    public enum Apply {
      /// Применить
      public static let title = L10n.tr("APRLocalizable", "Common.Apply.Title")
    }
    public enum Delete {
      /// Удалить
      public static let title = L10n.tr("APRLocalizable", "Common.Delete.Title")
    }
    public enum Join {
      /// Вступить
      public static let title = L10n.tr("APRLocalizable", "Common.Join.Title")
    }
    public enum Joined {
      /// Уже вступили
      public static let title = L10n.tr("APRLocalizable", "Common.Joined.Title")
    }
    public enum Measure {
      /// часов
      public static let hours = L10n.tr("APRLocalizable", "Common.Measure.Hours")
      /// мин
      public static let min = L10n.tr("APRLocalizable", "Common.Measure.Min")
      /// минут
      public static let minutes = L10n.tr("APRLocalizable", "Common.Measure.Minutes")
      /// сек
      public static let seconds = L10n.tr("APRLocalizable", "Common.Measure.Seconds")
    }
    public enum PlusAdd {
      /// + ДОБАВИТЬ
      public static let title = L10n.tr("APRLocalizable", "Common.PlusAdd.Title")
    }
    public enum ResetAll {
      /// Сбросить все
      public static let title = L10n.tr("APRLocalizable", "Common.ResetAll.Title")
    }
    public enum Save {
      /// Сохранить
      public static let title = L10n.tr("APRLocalizable", "Common.Save.Title")
    }
    public enum Share {
      /// Поделиться
      public static let title = L10n.tr("APRLocalizable", "Common.Share.Title")
    }
    public enum Skip {
      /// Пропустить
      public static let title = L10n.tr("APRLocalizable", "Common.Skip.Title")
    }
  }

  public enum Communities {
    public enum MyCommunity {
      /// Мои сообщества
      public static let title = L10n.tr("APRLocalizable", "Communities.MyCommunity.Title")
    }
  }

  public enum CreateActionFlow {
    public enum AboutCommunities {
      /// Подробнее о сообществах
      public static let title = L10n.tr("APRLocalizable", "CreateActionFlow.AboutCommunities.Title")
    }
    public enum ClearIngredients {
      /// Очистить
      public static let title = L10n.tr("APRLocalizable", "CreateActionFlow.ClearIngredients.Title")
    }
    public enum NewRecipe {
      /// Создать новый рецепт
      public static let title = L10n.tr("APRLocalizable", "CreateActionFlow.NewRecipe.Title")
    }
    public enum PrivateCommunity {
      /// Присоединиться могут только люди, которых вы пригласили
      public static let subtitle = L10n.tr("APRLocalizable", "CreateActionFlow.PrivateCommunity.Subtitle")
      /// Создать закрытое сообщество
      public static let title = L10n.tr("APRLocalizable", "CreateActionFlow.PrivateCommunity.Title")
    }
    public enum PublicCommunity {
      /// Любой может просматривать и присоединяться
      public static let subtitle = L10n.tr("APRLocalizable", "CreateActionFlow.PublicCommunity.Subtitle")
      /// Создать публичное сообщество
      public static let title = L10n.tr("APRLocalizable", "CreateActionFlow.PublicCommunity.Title")
    }
    public enum SavedRecipe {
      /// Добавить сохраненный рецепт
      public static let title = L10n.tr("APRLocalizable", "CreateActionFlow.SavedRecipe.Title")
    }
    public enum ShareCommunity {
      /// Поделиться сообществом
      public static let title = L10n.tr("APRLocalizable", "CreateActionFlow.ShareCommunity.Title")
    }
    public enum ShareIngredients {
      /// Поделиться
      public static let title = L10n.tr("APRLocalizable", "CreateActionFlow.ShareIngredients.Title")
    }
    public enum ShoppingList {
      /// Добавить в список покупок
      public static let title = L10n.tr("APRLocalizable", "CreateActionFlow.ShoppingList.Title")
    }
  }

  public enum CuisineSelection {
    /// Категории
    public static let category = L10n.tr("APRLocalizable", "CuisineSelection.Category")
  }

  public enum Filters {
    /// Время на кухне
    public static let cookingTime = L10n.tr("APRLocalizable", "Filters.CookingTime")
    /// Кухня мира
    public static let cuisines = L10n.tr("APRLocalizable", "Filters.Cuisines")
    /// Тип приема пищи
    public static let dayTimeType = L10n.tr("APRLocalizable", "Filters.DayTimeType")
    /// Тип блюда
    public static let dishTypes = L10n.tr("APRLocalizable", "Filters.DishTypes")
    /// Праздники
    public static let eventTypes = L10n.tr("APRLocalizable", "Filters.EventTypes")
    /// Добавить продукт
    public static let ingredients = L10n.tr("APRLocalizable", "Filters.Ingredients")
    /// Стиль жизни
    public static let lifestyleTypes = L10n.tr("APRLocalizable", "Filters.LifestyleTypes")
    public enum CuisinesKitchenPlus {
      /// Добавить кухню +
      public static let title = L10n.tr("APRLocalizable", "Filters.CuisinesKitchenPlus.Title")
    }
    public enum IngredientsPlus {
      /// Добавить продукт +
      public static let title = L10n.tr("APRLocalizable", "Filters.IngredientsPlus.Title")
    }
  }

  public enum Food {
    public enum CategoryType {
      /// Завтрак
      public static let breakfast = L10n.tr("APRLocalizable", "Food.CategoryType.Breakfast")
      /// Десерты
      public static let deserts = L10n.tr("APRLocalizable", "Food.CategoryType.Deserts")
      /// Ужин
      public static let dinner = L10n.tr("APRLocalizable", "Food.CategoryType.Dinner")
      /// Обед
      public static let lunch = L10n.tr("APRLocalizable", "Food.CategoryType.Lunch")
      /// Салаты
      public static let salads = L10n.tr("APRLocalizable", "Food.CategoryType.Salads")
      /// Закуски
      public static let snacks = L10n.tr("APRLocalizable", "Food.CategoryType.Snacks")
    }
  }

  public enum FoodCategories {
    public enum Bakery {
      /// Выпечки
      public static let title = L10n.tr("APRLocalizable", "FoodCategories.bakery.Title")
    }
    public enum Desserts {
      /// Десерты
      public static let title = L10n.tr("APRLocalizable", "FoodCategories.desserts.Title")
    }
    public enum Drinks {
      /// Напитки
      public static let title = L10n.tr("APRLocalizable", "FoodCategories.drinks.Title")
    }
    public enum FirstMeal {
      /// Первые блюда
      public static let title = L10n.tr("APRLocalizable", "FoodCategories.firstMeal.Title")
    }
    public enum FoodPrepProvision {
      /// Заготовки
      public static let title = L10n.tr("APRLocalizable", "FoodCategories.foodPrepProvision.Title")
    }
    public enum Salads {
      /// Салаты
      public static let title = L10n.tr("APRLocalizable", "FoodCategories.salads.Title")
    }
    public enum SaucesMarinades {
      /// Соусы и маринады
      public static let title = L10n.tr("APRLocalizable", "FoodCategories.saucesMarinades.Title")
    }
    public enum SecondMeal {
      /// Вторые блюда
      public static let title = L10n.tr("APRLocalizable", "FoodCategories.secondMeal.Title")
    }
    public enum SideDishes {
      /// Гарниры
      public static let title = L10n.tr("APRLocalizable", "FoodCategories.sideDishes.Title")
    }
    public enum Snacks {
      /// Закуски
      public static let title = L10n.tr("APRLocalizable", "FoodCategories.snacks.Title")
    }
  }

  public enum GeneralSearchInitialState {
    public enum En {
      /// Communities
      public static let community = L10n.tr("APRLocalizable", "GeneralSearchInitialState.EN.Community")
      /// Everything
      public static let everything = L10n.tr("APRLocalizable", "GeneralSearchInitialState.EN.Everything")
      /// Recipes
      public static let recipe = L10n.tr("APRLocalizable", "GeneralSearchInitialState.EN.Recipe")
    }
    public enum Ru {
      /// Сообщество
      public static let community = L10n.tr("APRLocalizable", "GeneralSearchInitialState.RU.Community")
      /// Все
      public static let everything = L10n.tr("APRLocalizable", "GeneralSearchInitialState.RU.Everything")
      /// Рецепты
      public static let recipe = L10n.tr("APRLocalizable", "GeneralSearchInitialState.RU.Recipe")
    }
  }

  public enum IngredientSelection {
    public enum Ingredient {
      /// Добавить ингредиент
      public static let add = L10n.tr("APRLocalizable", "IngredientSelection.Ingredient.Add")
      /// Пожалуйста, выберите ингредиент из списка
      public static let chooseFromList = L10n.tr("APRLocalizable", "IngredientSelection.Ingredient.ChooseFromList")
      /// Пожалуйста, выберите измерение
      public static let chooseMeasureTF = L10n.tr("APRLocalizable", "IngredientSelection.Ingredient.ChooseMeasureTF")
    }
  }

  public enum InstructionSelection {
    public enum AddStep {
      /// Добавить шаг
      public static let title = L10n.tr("APRLocalizable", "InstructionSelection.AddStep.Title")
    }
    public enum Description {
      /// Введите инструкцию
      public static let cellPlaceholder = L10n.tr("APRLocalizable", "InstructionSelection.Description.CellPlaceholder")
    }
  }

  public enum Main {
    public enum AdBanner {
      /// Для Вас
      public static let title = L10n.tr("APRLocalizable", "Main.AdBanner.Title")
    }
    public enum DayTimeCooking {
      /// Приготовить на
      public static let title = L10n.tr("APRLocalizable", "Main.DayTimeCooking.Title")
    }
    public enum WhenToCook {
      /// Что приготовить?
      public static let title = L10n.tr("APRLocalizable", "Main.WhenToCook.Title")
    }
  }

  public enum MealPlanner {
    /// Вы уверены?
    public static let areYouSure = L10n.tr("APRLocalizable", "MealPlanner.AreYouSure")
    /// Этот рецепт будет удален из вашего плана питания.
    public static let willBeDeletedFromYourPlan = L10n.tr("APRLocalizable", "MealPlanner.WillBeDeletedFromYourPlan")
  }

  public enum MyRecipes {
    /// У вас еще нет созданных рецептов
    public static let emptyListOfRecipes = L10n.tr("APRLocalizable", "MyRecipes.EmptyListOfRecipes")
    /// Не удалось получить ваши рецепты! Пожалуйста, попробуйте еще раз!
    public static let getProfileRecipeFailed = L10n.tr("APRLocalizable", "MyRecipes.GetProfileRecipeFailed")
  }

  public enum Photo {
    public enum Action {
      /// Сделать фото
      public static let camera = L10n.tr("APRLocalizable", "Photo.Action.Camera")
      /// Выбрать из галереи
      public static let gallery = L10n.tr("APRLocalizable", "Photo.Action.Gallery")
      /// Перейти в "Настройки"
      public static let settings = L10n.tr("APRLocalizable", "Photo.Action.Settings")
    }
    public enum Permission {
      public enum Camera {
        /// Требуется доступ к камере
        public static let title = L10n.tr("APRLocalizable", "Photo.Permission.Camera.Title")
      }
      public enum Gallery {
        /// Требуется доступ к галлерее
        public static let title = L10n.tr("APRLocalizable", "Photo.Permission.Gallery.Title")
      }
    }
    public enum UploadPhoto {
      /// Загрузить фото
      public static let title = L10n.tr("APRLocalizable", "Photo.UploadPhoto.Title")
      public enum Advice {
        /// Убедитесь, что вы подключены к 4G (LTE) или Wi-Fi. Через 3G фото может не загрузиться
        public static let connection = L10n.tr("APRLocalizable", "Photo.UploadPhoto.Advice.Connection")
        /// Пожалуйста, используйте только свои уникальные фотографии. Формат JPG, JPEG, PNG. Размер до 20 мб
        public static let format = L10n.tr("APRLocalizable", "Photo.UploadPhoto.Advice.Format")
      }
      public enum Error {
        /// Не удалось загрузить фото, попробуйте еще раз
        public static let title = L10n.tr("APRLocalizable", "Photo.UploadPhoto.Error.Title")
      }
    }
  }

  public enum PreshoppingList {
    public enum ChooseAtLeastOneProduct {
      /// Пожалуйста, выберите не менее 1 продукта
      public static let title = L10n.tr("APRLocalizable", "PreshoppingList.ChooseAtLeastOneProduct.Title")
    }
  }

  public enum Profile {
    public enum Assistant {
      /// Голосовой ассистент
      public static let title = L10n.tr("APRLocalizable", "Profile.Assistant.Title")
    }
    public enum ContactWithDevelopers {
      /// Сообщить о проблеме
      public static let title = L10n.tr("APRLocalizable", "Profile.ContactWithDevelopers.Title")
    }
    public enum DeleteAccount {
      /// Удалить аккаунт
      public static let title = L10n.tr("APRLocalizable", "Profile.DeleteAccount.Title")
    }
    public enum Logout {
      /// Выйти
      public static let title = L10n.tr("APRLocalizable", "Profile.Logout.Title")
    }
    public enum MyRecipes {
      /// Мои рецепты
      public static let title = L10n.tr("APRLocalizable", "Profile.MyRecipes.Title")
    }
  }

  public enum Recipe {
    /// Ингредиенты
    public static let ingredients = L10n.tr("APRLocalizable", "Recipe.Ingredients")
    /// Инструкция
    public static let instructions = L10n.tr("APRLocalizable", "Recipe.Instructions")
    /// порции
    public static let servings = L10n.tr("APRLocalizable", "Recipe.Servings")
    public enum Calories {
      /// УГЛЕВОДЫ
      public static let carbs = L10n.tr("APRLocalizable", "Recipe.Calories.Carbs")
      /// ЖИРЫ
      public static let fat = L10n.tr("APRLocalizable", "Recipe.Calories.Fat")
      /// БЕЛКИ
      public static let protein = L10n.tr("APRLocalizable", "Recipe.Calories.Protein")
      /// Ккал на 100 гр
      public static let subtitle = L10n.tr("APRLocalizable", "Recipe.Calories.Subtitle")
      /// Калорийность
      public static let title = L10n.tr("APRLocalizable", "Recipe.Calories.Title")
    }
    public enum Cook {
      public enum StepByStep {
        /// Режим готовки
        public static let title = L10n.tr("APRLocalizable", "Recipe.Cook.StepByStep.Title")
      }
    }
    public enum Ingredients {
      /// Добавить в корзину
      public static let addToCart = L10n.tr("APRLocalizable", "Recipe.Ingredients.AddToCart")
    }
    public enum Moderator {
      /// Замечания от модератора:\n
      public static let message = L10n.tr("APRLocalizable", "Recipe.Moderator.Message")
    }
    public enum Reviews {
      /// Оставьте ваш отзыв
      public static let tfPlaceholder = L10n.tr("APRLocalizable", "Recipe.Reviews.TFPlaceholder")
      /// Отзывы
      public static let title = L10n.tr("APRLocalizable", "Recipe.Reviews.Title")
    }
    public enum Step {
      /// шаг
      public static let title = L10n.tr("APRLocalizable", "Recipe.Step.Title")
    }
    public enum StepByStep {
      public enum Timer {
        /// Шаг №
        public static let step = L10n.tr("APRLocalizable", "Recipe.StepByStep.Timer.Step")
        /// Таймер
        public static let title = L10n.tr("APRLocalizable", "Recipe.StepByStep.Timer.Title")
      }
    }
  }

  public enum RecipeCreation {
    public enum Description {
      /// Напишете описание вашего блюда
      public static let tfPlaceholder = L10n.tr("APRLocalizable", "RecipeCreation.Description.TFPlaceholder")
    }
    public enum DialogAlert {
      /// Заполнить
      public static let fillButton = L10n.tr("APRLocalizable", "RecipeCreation.DialogAlert.FillButton")
      /// Пожалуйста, заполните все поля, чтобы облегчить готовку остальным пользователям пользователям. Спасибо!
      public static let message = L10n.tr("APRLocalizable", "RecipeCreation.DialogAlert.Message")
      /// Понятно
      public static let okayButton = L10n.tr("APRLocalizable", "RecipeCreation.DialogAlert.OkayButton")
      /// Обязательные поля!
      public static let title = L10n.tr("APRLocalizable", "RecipeCreation.DialogAlert.Title")
    }
    public enum MessageAlert {
      /// Смотрите статус своих рецептов в "Мои рецепты"
      public static let success = L10n.tr("APRLocalizable", "RecipeCreation.MessageAlert.Success")
    }
    public enum NewRecipe {
      /// Новый рецепт
      public static let title = L10n.tr("APRLocalizable", "RecipeCreation.NewRecipe.Title")
    }
    public enum Recipe {
      /// Описание
      public static let description = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.Description")
      /// +  Добавьте ингредиенты
      public static let ingredientsTF = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.IngredientsTF")
      /// Ингредиенты
      public static let ingredientsTitle = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.IngredientsTitle")
      /// +  Добавьте шаги приготовления
      public static let instructionsTF = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.InstructionsTF")
      /// Инструкция
      public static let instructionsTitle = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.InstructionsTitle")
      public enum AssignButton {
        /// Задать
        public static let title = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.AssignButton.Title")
      }
      public enum CookTime {
        /// Сколько времени нужно, что бы приготовить это блюдо?
        public static let subtitle = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.CookTime.Subtitle")
        /// Время готовки
        public static let title = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.CookTime.Title")
      }
      public enum Name {
        /// Напишите название рецепта
        public static let tfPlaceholder = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.Name.TFPlaceholder")
      }
      public enum Paid {
        /// Добавьте к своему рецепту фотографию, а в описании рецепта укажите не менее трех шагов с фото. Для того, чтобы мы могли отправить подарок, укажите, пожалуйста, свой номер телефона
        public static let descr = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.Paid.Descr")
        /// Подарок будет отправлен на указанный номер по WhatsApp
        public static let emailDescr = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.Paid.EmailDescr")
        /// Напишите номер телефона (WhatsApp)
        public static let emailTF = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.Paid.EmailTF")
        /// Номер телефона *
        public static let emailTitle = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.Paid.EmailTitle")
        /// Укажите правильный промокод по которому вы пришли для получения подарка
        public static let promoDescr = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.Paid.PromoDescr")
        /// Напишите промо код
        public static let promoTF = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.Paid.PromoTF")
        /// Введите промокод *
        public static let promoTitle = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.Paid.PromoTitle")
        /// Получить подарок
        public static let title = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.Paid.Title")
      }
      public enum ServingCount {
        /// Используется для изменения рецепта и подсчитывания каллорийности блюда
        public static let subtitle = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.ServingCount.Subtitle")
        /// Количество порции
        public static let title = L10n.tr("APRLocalizable", "RecipeCreation.Recipe.ServingCount.Title")
      }
    }
    public enum StartAlert {
      /// Вы недавно были в процессе создания рецепта. Вы хотите продолжить с того места, на котором остановились?
      public static let message = L10n.tr("APRLocalizable", "RecipeCreation.StartAlert.Message")
      /// Продолжить создание рецепта?
      public static let title = L10n.tr("APRLocalizable", "RecipeCreation.StartAlert.Title")
    }
    public enum Tags {
      /// Укажите тип блюда
      public static let dishType = L10n.tr("APRLocalizable", "RecipeCreation.Tags.DishType")
      /// Укажите праздники
      public static let event = L10n.tr("APRLocalizable", "RecipeCreation.Tags.Event")
      /// Укажите образ жизни
      public static let lifestyle = L10n.tr("APRLocalizable", "RecipeCreation.Tags.Lifestyle")
      /// Укажите тип приема пищи
      public static let whenToCook = L10n.tr("APRLocalizable", "RecipeCreation.Tags.WhenToCook")
    }
  }

  public enum RecipeSearch {
    public enum AllFilters {
      /// Все фильтры
      public static let title = L10n.tr("APRLocalizable", "RecipeSearch.AllFilters.Title")
    }
    public enum RecipeSearch {
      /// Поиск по рецептам
      public static let title = L10n.tr("APRLocalizable", "RecipeSearch.RecipeSearch.Title")
    }
  }

  public enum ResultListEndpoint {
    public enum GetCommunities {
      /// communities
      public static let title = L10n.tr("APRLocalizable", "ResultListEndpoint.getCommunities.Title")
    }
    public enum GetEverything {
      /// recipes/searchByRecipesAndCommunities
      public static let title = L10n.tr("APRLocalizable", "ResultListEndpoint.getEverything.Title")
    }
    public enum GetRecipes {
      /// recipes
      public static let title = L10n.tr("APRLocalizable", "ResultListEndpoint.getRecipes.Title")
    }
    public enum GetRecipesByCommunityID {
      /// recipes/recipesByCommunityId
      public static let title = L10n.tr("APRLocalizable", "ResultListEndpoint.getRecipesByCommunityID.Title")
    }
    public enum GetSavedRecipes {
      /// recipes/mySavedRecipes
      public static let title = L10n.tr("APRLocalizable", "ResultListEndpoint.getSavedRecipes.Title")
    }
    public enum JoinCommunity {
      /// communities/join/
      public static let title = L10n.tr("APRLocalizable", "ResultListEndpoint.joinCommunity.Title")
    }
    public enum SaveRecipe {
      /// recipes/saveRecipe/
      public static let title = L10n.tr("APRLocalizable", "ResultListEndpoint.saveRecipe.Title")
    }
  }

  public enum SavedRecipes {
    /// recipes/mySavedRecipes
    public static let getRecipes = L10n.tr("APRLocalizable", "SavedRecipes.getRecipes")
    public enum AddFavoriteRecipes {
      /// Добавляйте свои любимые рецепты,\n чтобы быстрее их найти
      public static let title = L10n.tr("APRLocalizable", "SavedRecipes.AddFavoriteRecipes.Title")
    }
    public enum SavedRecipes {
      /// Сохраненные рецепты
      public static let title = L10n.tr("APRLocalizable", "SavedRecipes.SavedRecipes.Title")
    }
  }

  public enum Search {
    /// Поиск
    public static let search = L10n.tr("APRLocalizable", "Search.Search")
    /// Поиск рецептов
    public static let title = L10n.tr("APRLocalizable", "Search.Title")
    public enum Cancel {
      /// Cancel
      public static let title = L10n.tr("APRLocalizable", "Search.Cancel.Title")
    }
    public enum NotFound {
      /// Ничего не найдено
      public static let title = L10n.tr("APRLocalizable", "Search.NotFound.Title")
    }
  }

  public enum ShoppingList {
    /// Купленные ингредиенты
    public static let boughtIngredients = L10n.tr("APRLocalizable", "ShoppingList.BoughtIngredients")
    /// Ингредиенты
    public static let ingredients = L10n.tr("APRLocalizable", "ShoppingList.Ingredients")
    public enum AddProduct {
      /// Добавить продукт
      public static let title = L10n.tr("APRLocalizable", "ShoppingList.AddProduct.Title")
    }
    public enum AddProductsToBuyList {
      /// Добавьте товары в свой список покупок
      public static let title = L10n.tr("APRLocalizable", "ShoppingList.AddProductsToBuyList.Title")
    }
    public enum CannotCleanCart {
      /// Не удалось очистить корзину
      public static let title = L10n.tr("APRLocalizable", "ShoppingList.CannotCleanCart.Title")
    }
    public enum CannotUploadCart {
      /// Не удалось загрузить корзину
      public static let title = L10n.tr("APRLocalizable", "ShoppingList.CannotUploadCart.Title")
    }
    public enum ListOfProducts {
      /// Список покупок
      public static let title = L10n.tr("APRLocalizable", "ShoppingList.ListOfProducts.Title")
    }
    public enum Order {
      /// Заказать
      public static let title = L10n.tr("APRLocalizable", "ShoppingList.Order.Title")
    }
    public enum SelfProduct {
      /// Личный продукт
      public static let title = L10n.tr("APRLocalizable", "ShoppingList.SelfProduct.Title")
    }
  }

  public enum StepByStepMode {
    public enum CloseCookingMode {
      /// Вы действительно хотите закрыть режим готовки?
      public static let title = L10n.tr("APRLocalizable", "StepByStepMode.CloseCookingMode.Title")
    }
    public enum LeaveFeedback {
      /// Оставить отзыв
      public static let title = L10n.tr("APRLocalizable", "StepByStepMode.LeaveFeedback.Title")
    }
    public enum PauseTimer {
      /// Вы точно хотите остановить таймер?
      public static let title = L10n.tr("APRLocalizable", "StepByStepMode.PauseTimer.Title")
    }
    public enum StartTimer {
      /// Начать таймер
      public static let title = L10n.tr("APRLocalizable", "StepByStepMode.StartTimer.Title")
    }
  }

  public enum TabBar {
    public enum Home {
      /// Главная
      public static let title = L10n.tr("APRLocalizable", "TabBar.Home.Title")
    }
    public enum MealPlanner {
      /// Планировщик
      public static let title = L10n.tr("APRLocalizable", "TabBar.MealPlanner.Title")
    }
    public enum Profile {
      /// Профиль
      public static let title = L10n.tr("APRLocalizable", "TabBar.Profile.Title")
    }
    public enum RecipeCreation {
      /// Добавить
      public static let title = L10n.tr("APRLocalizable", "TabBar.RecipeCreation.Title")
    }
    public enum Saved {
      /// Избранное
      public static let title = L10n.tr("APRLocalizable", "TabBar.Saved.Title")
    }
    public enum Search {
      /// Поиск
      public static let title = L10n.tr("APRLocalizable", "TabBar.Search.Title")
    }
    public enum ShoppingList {
      /// Список
      public static let title = L10n.tr("APRLocalizable", "TabBar.ShoppingList.Title")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    let bundleToken = Bundle(for: BundleToken.self)
    guard let url = bundleToken.url(forResource: "APRUIKit", withExtension: "bundle"),
      let bundle = Bundle(url: url) else {
      fatalError("Can't find 'APRUIKit' resources bundle")
    }
    return bundle
  }()
}
// swiftlint:enable convenience_type
