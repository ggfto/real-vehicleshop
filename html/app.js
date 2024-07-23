import importTemplate from './utils/importTemplate.js';
import inlinesvg from './utils/inlineSvg.js';
import { FormatMoney, CalculateVehicleStatistic, ShowNotify } from './utils/functions.js';

const preview = {
    template: await importTemplate('./pages/preview.html')
}
const dashboard = {
    template: await importTemplate('./pages/bossmenu/dashboard.html')
}
const company = {
    template: await importTemplate('./pages/bossmenu/company.html')
}
const companysettings = {
    template: await importTemplate('./pages/bossmenu/company/settings.html')
}
const companystaffsettings = {
    template: await importTemplate('./pages/bossmenu/company/staffsettings.html')
}
const bosspopup = {
    template: await importTemplate('./pages/bossmenu/bosspopup.html')
}
const perms = {
    template: await importTemplate('./pages/bossmenu/perms.html')
}
const feedbackcomplains = {
    template: await importTemplate('./pages/bossmenu/feedbacks.html')
}
const vehicles = {
    template: await importTemplate('./pages/bossmenu/vehicles.html')
}
const category = {
    template: await importTemplate('./pages/bossmenu/category.html')
}
const buyvehicle = {
    template: await importTemplate('./pages/bossmenu/buyvehicle.html')
}

const store = Vuex.createStore({
    state: {},
    mutations: {},
    actions: {}
});

const app = Vue.createApp({
    components: {
        preview,
        inlinesvg,
        dashboard,
        company,
        companysettings,
        companystaffsettings,
        perms,
        feedbackcomplains,
        vehicles,
        category,
        buyvehicle,
        bosspopup
    },
    
    data: () => ({
        Show: false,
        ShowTestDriveTime: false,
        MainPage: 'Normal', // 'Normal', 'Component', "Bossmenu"
        activePage: 'dashboard', // 'preview', 'dashboard', 'company', 'companysettings', 'companystaffsettings', 'perms', 'feedbackcomplains', 'vehicles', 'category', 'buyvehicle'
        HasOwner: false,

        // Player Information
        PlayerName: "Oph3Z Second",
        PlayerRank: 'Owner',
        PlayerMoney: 1000000,
        PlayerPfp: "https://cdn.discordapp.com/attachments/926499504922959922/1258479292023832709/image.png?ex=668a2bec&is=6688da6c&hm=b5c4fcc212b673d6d36c870239620b9f0574ce58944b991ff1a3e533437849f9&",

        // Main Informations
        CurrentVehicleshop: -1,
        ShiftPressed: false,
        DraggingCheck: false,
        MouseX: null,
        MouseY: null,
        CameraAngle: 'exterior',
        TestDriveTime: 0,

        // Vehicleshop Variables
        VehicleShopName: "Oph3Z's Dealership",
        VehicleshopDescription: "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quaerat illum aperiam neque nisi nemo itaque error voluptatem, ut minus, eaque ex similique maxime!",
        VehicleShopStar: 4,
        Discount: 0,
        Raise: 0,
        TestDrivePrice: 7500,
        ShowColorPicker: false,
        ColorPickerColor: "#FFFFFF",
        SelectedColor: null,
        ColorsTable: [],
        AllowPlateChange: true,
        PlateChangePrice: 0,
        ShowPlateChange: false,
        PlateInput: "",
        ChangedPlate: false,
        CategoryList: [],
        SelectedVehicleEditCategory: -1,
        SelectedVehicleCategory: 'all',
        VehiclesTable: [
            {
                name: 't20',
                label: 'T20',
                model: 'Super',
                category: 'sports',
                price: 13000000,
                stock: 20,
                img: 'https://docs.fivem.net/vehicles/t20.webp',
                discount: '',
                information: {
                    TopSpeed: 273,
                    Braking: 100,
                    Acceleration: 89,
                    Suspension: 100,
                    Handling: 89
                }
            },
            {
                name: 'elegy',
                label: 'Elegy',
                model: 'Custom',
                category: 'sports',
                price: 2500000,
                stock: 0,
                img: 'https://docs.fivem.net/vehicles/elegy.webp',
                discount: '',
                information: {
                    TopSpeed: 273,
                    Braking: 100,
                    Acceleration: 89,
                    Suspension: 100,
                    Handling: 89
                }
            },
            {
                name: 'sultanrs',
                label: 'Sultan RS',
                model: 'Normal',
                category: 'sedans',
                price: 1000000,
                stock: 2,
                img: 'https://docs.fivem.net/vehicles/sultanrs.webp',
                discount: '',
                information: {
                    TopSpeed: 123,
                    Braking: 75,
                    Acceleration: 89,
                    Suspension: 100,
                    Handling: 45
                }
            },
            {
                name: 'sultanrs',
                label: 'Sultan RS',
                model: 'Normal',
                category: 'sedans',
                price: 1000000,
                stock: 2,
                img: 'https://docs.fivem.net/vehicles/sultanrs.webp',
                discount: '',
                information: {
                    TopSpeed: 273,
                    Braking: 100,
                    Acceleration: 89,
                    Suspension: 100,
                    Handling: 89
                }
            },
            {
                name: 'sultanrs',
                label: 'Sultan RS',
                model: 'Normal',
                category: 'sedans',
                price: 1000000,
                stock: 2,
                img: 'https://docs.fivem.net/vehicles/sultanrs.webp',
                discount: '',
                information: {
                    TopSpeed: 273,
                    Braking: 100,
                    Acceleration: 89,
                    Suspension: 100,
                    Handling: 89
                }
            },
            {
                name: 'sultanrs',
                label: 'Sultan RS',
                model: 'Normal',
                category: 'sedans',
                price: 1000000,
                stock: 2,
                img: 'https://docs.fivem.net/vehicles/sultanrs.webp',
                discount: '',
                information: {
                    TopSpeed: 273,
                    Braking: 100,
                    Acceleration: 89,
                    Suspension: 100,
                    Handling: 89
                }
            },
        ],
        AllVehicleData: [],
        SelectedBuyVehicle: -1, // Seçilen araç (Araç satın alma ekranında | Boss menu)
        SelectedVehicleTable: {
            VehicleIndex: -1,
            VehicleHash: "",
            VehicleLabel: "",
            VehicleModel: "",
            VehiclePrice: 0,
            VehicleStock: null,
            VehicleTopSpeed: 0,
            VehicleBraking: 0,
            VehicleAcceleration: 0,
            VehicleSuspension: 0,
            VehicleHandling: 0,
        },
        SearchInput: "",
        IsSearching: false,
        ShowFeedback: false,
        Feedbacks: [
            {
                name: "Oph3Z Test",
                pfp: "./img/background.png",
                stars: 4,
                message: "Lorem ipsum dolor sit amet consectetur adipisicing elit. At assumenda praesentium in similique commodi nihil ut debitis, consequatur consectetur possimus dolor fugit quo quae dolorem reprehenderit vel sapiente. Pariatur voluptas, natus ex tempora cumque quidem ipsam, laborum possimus, nihil culpa minima sapiente dolorem beatae libero totam! Excepturi illum, necessitatibus deleniti laboriosam hic quidem id fugiat perspiciatis est fuga dolor sunt quod beatae ut. Quod voluptate culpa, veritatis praesentium nobis nostrum."
            },
            {
                name: "Oph3Z Test",
                pfp: "./img/background.png",
                stars: 2,
                message: "Lorem ipsum dolor sit amet consectetur adipisicing elit. At assumenda praesentium in similique commodi nihil ut debitis, consequatur consectetur possimus dolor fugit quo quae dolorem reprehenderit vel sapiente. Pariatur voluptas, natus ex tempora cumque quidem ipsam, laborum possimus, nihil culpa minima sapiente dolorem beatae libero totam! Excepturi illum, necessitatibus deleniti laboriosam hic quidem id fugiat perspiciatis est fuga dolor sunt quod beatae ut. Quod voluptate culpa, veritatis praesentium nobis nostrum."
            },
            {
                name: "Oph3Z Test",
                pfp: "./img/background.png",
                stars: 3,
                message: "Lorem ipsum dolor sit amet consectetur adipisicing elit. At assumenda praesentium in similique commodi nihil ut debitis, consequatur consectetur possimus dolor fugit quo quae dolorem reprehenderit vel sapiente. Pariatur voluptas, natus ex tempora cumque quidem ipsam, laborum possimus, nihil culpa minima sapiente dolorem beatae libero totam! Excepturi illum, necessitatibus deleniti laboriosam hic quidem id fugiat perspiciatis est fuga dolor sunt quod beatae ut. Quod voluptate culpa, veritatis praesentium nobis nostrum."
            },
            {
                name: "Oph3Z Test",
                pfp: "./img/background.png",
                stars: 4,
                message: "Lorem ipsum dolor sit amet consectetur adipisicing elit. At assumenda praesentium in similique commodi nihil ut debitis, consequatur consectetur possimus dolor fugit quo quae dolorem reprehenderit vel sapiente. Pariatur voluptas, natus ex tempora cumque quidem ipsam, laborum possimus, nihil culpa minima sapiente dolorem beatae libero totam! Excepturi illum, necessitatibus deleniti laboriosam hic quidem id fugiat perspiciatis est fuga dolor sunt quod beatae ut. Quod voluptate culpa, veritatis praesentium nobis nostrum."
            },
            {
                name: "Oph3Z Test",
                pfp: "./img/background.png",
                stars: 1,
                message: "Lorem ipsum dolor sit amet consectetur adipisicing elit. At assumenda praesentium in similique commodi nihil ut debitis, consequatur consectetur possimus dolor fugit quo quae dolorem reprehenderit vel sapiente. Pariatur voluptas, natus ex tempora cumque quidem ipsam, laborum possimus, nihil culpa minima sapiente dolorem beatae libero totam! Excepturi illum, necessitatibus deleniti laboriosam hic quidem id fugiat perspiciatis est fuga dolor sunt quod beatae ut. Quod voluptate culpa, veritatis praesentium nobis nostrum."
            },
        ],
        VehicleStatisticMaxValues: {
            MaxSpeed: 500,
            MaxBrake: 200,
            MaxAcceleration: 2500,
            MaxSuspension: 400,
            MaxHandling: 100
        },

        // Boss menu Variables
        CompanyMoney: 0,
        BossmenuCategory: [],
        SelectedBossmenuCategory: 0,
        Preorders: [
            {
                identifier: "",
                requestor: "Oph3Z Test",
                vehiclehash: "t20",
                vehiclemodel: "T20",
                price: 10000000
            },
        ],
        EmployeesTable: [
            {
                identifier: "",
                name: "Oph3Z Test",
                pp: "https://cdn.discordapp.com/attachments/926499504922959922/1258479292023832709/image.png?ex=668a2bec&is=6688da6c&hm=b5c4fcc212b673d6d36c870239620b9f0574ce58944b991ff1a3e533437849f9&",
                rank: "Worker",
                salary: 1000,
                salarypenalty: 0
            },
        ],
        SoldVehiclesLog: [
            {
                buyer: 'Oph3Z Sane',
                vehicle: "T20",
                price: 1000000,
                date: '05.07.2024 | 16:25'
            },
        ],
        Transactions: [
            {
                name: 'Oph3Z Second',
                pfp: 'https://cdn.discordapp.com/attachments/926499504922959922/1258479292023832709/image.png?ex=668a2bec&is=6688da6c&hm=b5c4fcc212b673d6d36c870239620b9f0574ce58944b991ff1a3e533437849f9&',
                rank: 'Owner',
                amount: 10000,
                date: '05.07.2024 | 16:25',
                type: 'withdraw'
            },
        ],
        PermsTable: [
            {
                name: 'owner',
                label: "Owner",
                permissions: [
                    { name: 'withdrawdeposit', label: 'Withdraw & Deposit', description: 'Player can withdraw and deposit money.', value: true },
                    { name: 'preorder', label: 'Preorder', description: 'Player can accept/reject preorder request.', value: true },
                    { name: 'discount', label: 'Discount', description: 'Player can start discount campaign.', value: true },
                    { name: 'removelog', label: 'Remove Log', description: 'Player can remove all log data.', value: true },
                    { name: 'bonus', label: 'Bonus', description: 'Player can give bonus to other staff members.', value: true },
                    { name: 'raise', label: 'Raise', description: 'Player can bring a raise.', value: true },
                    { name: 'fire', label: 'Fire Employees', description: 'Player can fire staff members.', value: true },
                    { name: 'rankchange', label: 'Edit Staff Rank', description: 'Player can demote and promote employees.', value: true },
                    { name: 'hire', label: 'Hire Staff', description: 'Player can hire staff members.', value: true },
                    { name: 'penalty', label: 'Give Penalty', description: 'Player can give penalty to other staff members.', value: true },
                    { name: 'category', label: 'Edit/Remove/Add Category', description: 'Player can add, remove and edit categories.', value: true },
                    { name: 'buyvehicle', label: 'Buy Vehicle Stock', description: 'Player can buy vehicle stock.', value: true },
                    { name: 'editvehicle', label: 'Edit Vehicles', description: 'Player can edit vehicle category, price, give discount etc.', value: true },
                    { name: 'removefeedback', label: 'Remove Feedbacks', description: 'Player can remove feedbacks.', value: true },
                    { name: 'removecomplaints', label: 'Remove Complaints', description: 'Player can remove complaints.', value: true },

                ],
                removable: false,
                editable: false,
            },
            {
                name: 'manager',
                label: 'Manager',
                permissions: [
                    { name: 'withdrawdeposit', label: 'Withdraw & Deposit', description: 'Player can withdraw and deposit money.', value: false },
                    { name: 'preorder', label: 'Preorder', description: 'Player can accept/reject preorder request.', value: true },
                    { name: 'discount', label: 'Discount', description: 'Player can start discount campaign.', value: true },
                    { name: 'removelog', label: 'Remove Log', description: 'Player can remove all log data.', value: true },
                    { name: 'bonus', label: 'Bonus', description: 'Player can give bonus to other staff members.', value: true },
                    { name: 'raise', label: 'Raise', description: 'Player can bring a raise.', value: true },
                    { name: 'fire', label: 'Fire Employees', description: 'Player can fire staff members.', value: true },
                    { name: 'rankchange', label: 'Edit Staff Rank', description: 'Player can demote and promote employees.', value: false },
                    { name: 'hire', label: 'Hire Staff', description: 'Player can hire staff members.', value: true },
                    { name: 'penalty', label: 'Give Penalty', description: 'Player can give penalty to other staff members.', value: false },
                    { name: 'category', label: 'Edit/Remove/Add Category', description: 'Player can add, remove and edit categories.', value: true },
                    { name: 'buyvehicle', label: 'Buy Vehicle Stock', description: 'Player can buy vehicle stock.', value: false },
                    { name: 'editvehicle', label: 'Edit Vehicles', description: 'Player can edit vehicle category, price, give discount etc.', value: true },
                    { name: 'removefeedback', label: 'Remove Feedbacks', description: 'Player can remove feedbacks.', value: false },
                    { name: 'removecomplaints', label: 'Remove Complaints', description: 'Player can remove complaints.', value: false },

                ],
                removable: true,
                editable: true,
            },
        ],
        SelectedPerm: -1,
        OriginalPermsTable: null,
        BossmenuPageSettings: {
            PreorderPage: 1,
            SoldVehiclesPage: 1,
            TransactionsPage: 1,
            EmployeeWithPenaltyPage: 1,
            EmployeesPage: 1,
        },
        FeedbackComplaintScreen: -1,
        VehicleEditScreen: -1, // Selected vehicle table number
        SelectedShowCategory: 0, // 'category' - page (When clicking 'Show')

        // Notify
        NotifySettings: {
            Show: false,
            Type: '', // success, information, error
            Message: '',
            Time: 0,
        },

        // Popup Settings
        ShowPopupScrren: false,
        NormalPopupSettings: {
            Show: false,
            HeaderOne: '',
            HeaderTwo: '',
            Description: '',
            Function: null
        },
        FeedbackPopupSettings: {
            Show: false,
            Rating: null,
            Message: '',
        },
        ComplaintPopupSettings: {
            Show: false,
            Message: '',
        },

        // Boss Menu Popup Settings
        ShowBossPopup: '', // deposit, withdraw, createperm, vehicleedit, createcategory, editcategory, buyvehicle

        // Popup Without UI (Req to other players)
        ShowPopupToTarget: '', // 'TransferRequest', 'JobReq'

        // TransferReq Settings
        TransferReqCompanyName: 'Oph3Z Vehicleshop',
        TransferReqCompanyPrice: 1000000,
        TransferReqFunctions: '',

        // JobReq Settings
        JobReqCompanyName: 'Test Vehicleshop',
        JobReqSalary: 15000,

        // Detailed Variables
        CheckProfanities: true,
        Profanities: [],
        FeedbackCharacters: {},
        ComplaintCharacters: {},

        // Tables
        ComplainTable: [
            {
                name: "Oph3Z Test",
                pfp: "./img/background.png",
                message: "Lorem ipsum dolor sit amet consectetur adipisicing elit. At assumenda praesentium in similique commodi nihil ut debitis, consequatur consectetur possimus dolor fugit quo quae dolorem reprehenderit vel sapiente. Pariatur voluptas, natus ex tempora cumque quidem ipsam, laborum possimus, nihil culpa minima sapiente dolorem beatae libero totam! Excepturi illum, necessitatibus deleniti laboriosam hic quidem id fugiat perspiciatis est fuga dolor sunt quod beatae ut. Quod voluptate culpa, veritatis praesentium nobis nostrum."
            },
        ],

        Inputs: {
            SoldVehiclesInput: '', // Satılmış araçlar arama input
            CompanyNameInput: '', // Şirket ismi değiştirme
            TransferIdInput: '',  // Transfer
            TransferPriceInput: '', // Transfer
            DiscountInput: '', // İndirim
            BonusesInput: '', // Prim
            RaiseInput: '', // Zam
            TransactionsInput: '', // Para Çekme/Yatırma arama input
            EmployeeIdInput: '', // İşe alma
            EmployeeSalaryInput: '', // İşe alma
            SalaryPenaltyIdInput: '', // Maaş cezası
            SalaryPenaltyInput: '', // İkinci input
            PenaltySearchInput: '', // Maaş cezası
            EmployeesInput: '', // Çalışanlar listesi
            DepositInput: '', // Para yatırma input
            WithdrawInput: '', // Para çekme input
            PermNameInput: '', // Perm oluşturma name
            PermLabelInput: '', // Perm oluşturma label
            CategoryNameInput: '', // Kategori oluşturma name
            CategoryLabelInput: '', // Kategori oluşturma label
        },

        EditVehicleInputs: {
            Name: '',
            Model: '',
            Img: '',
            Discount: '',
            Price: '',
        },

        BuyVehicleInputs: {
            Stock: 1,
            Price: '',
            SelectedCategoryIndex: -1
        },

        // Language
        Language: {},

        // Extras
        CurrentVehicleColor: null,
    }),

    methods: {
        setActivePage(page) {
            this.activePage = page
        },

        FormatMoney(s) {
            return FormatMoney(s)
        },

        BuyVehicle() {
            this.ShowPopupScrren = true
            this.NormalPopupSettings.Show = true
            this.NormalPopupSettings.HeaderOne = this.Language['buyvehicle_header']
            if (this.ChangedPlate) {
                this.NormalPopupSettings.HeaderTwo = '$' + this.FormatMoney(this.SelectedVehicleTable.VehiclePrice) + ' + ' + this.FormatMoney(this.PlateChangePrice)
            } else {
                this.NormalPopupSettings.HeaderTwo = '$' + this.FormatMoney(this.SelectedVehicleTable.VehiclePrice)
            }
            this.NormalPopupSettings.Description = this.Language['buyvehicle_description']
            this.NormalPopupSettings.Function = 'buyvehicle'
        },

        ConfirmBuyVehicle() {
            if (this.PlayerMoney >= this.SelectedVehicleTable.VehiclePrice) {
                let SelectedVehiclePrice = this.SelectedVehicleTable.VehiclePrice
                if (this.ChangedPlate) {
                    SelectedVehiclePrice = SelectedVehiclePrice + this.PlateChangePrice
                }
                postNUI('BuyPlayerVehicle', {
                    vehicleshop: this.CurrentVehicleshop,
                    model: this.SelectedVehicleTable.VehicleHash,
                    price: SelectedVehiclePrice,
                    stock: this.SelectedVehicleTable.VehicleStock,
                    plate: this.PlateInput,
                    color: this.CurrentVehicleColor
                })
            } else {
                this.ShowNotify('error', this.Language['not_enough_money'], 2000)
            }
        },

        TestDrive() {
            this.ShowPopupScrren = true
            this.NormalPopupSettings.Show = true
            this.NormalPopupSettings.HeaderOne = this.Language['testdrive_header']
            this.NormalPopupSettings.HeaderTwo = '$' + this.FormatMoney(this.TestDrivePrice)
            this.NormalPopupSettings.Description = this.Language['testdrive_description']
            this.NormalPopupSettings.Function = 'testdrive'
        },

        StartTestDrive() {
            if (this.PlayerMoney >= this.TestDrivePrice) {
                postNUI('StartTestDrive', {
                    vehicleshop: this.CurrentVehicleshop,
                    vehicle: this.SelectedVehicleTable.VehicleHash,
                    color: this.CurrentVehicleColor
                })
                this.CloseUI(false)
            } else {
                this.ShowNotify('error', this.Language['not_enough_money'], 2000)
            }
        },

        VehicleshopPopupFunction(type) {
            if (type == 'testdrive') {
                this.StartTestDrive()
            } else if (type == 'buyvehicle') {
                this.ConfirmBuyVehicle()
            }
        },

        SetColorPicker() {
            this.ShowColorPicker = !this.ShowColorPicker

            if (this.ShowPlateChange) {
                this.ShowPlateChange = false
                this.PlateInput = ""
            }

            if (this.ShowColorPicker) {
                this.OpenColorPicker()
                postNUI('ChangeVehicleColorFromPopup', this.ColorPickerColor)
            } else {
                this.ColorPickerColor = "#FFFFFF"
                postNUI('ChangeVehicleColor', this.CurrentVehicleColor)
            }
        },

        OpenColorPicker() {
            this.$nextTick(() => {
                const colorPicker = new iro.ColorPicker("#color-picker", {
                    width: 160,
                    color: this.ColorPickerColor,
                    layout: [
                        {
                            component: iro.ui.Wheel,
                            options: {}
                        }
                    ]
                });
                colorPicker.on('color:change', (color) => {
                    this.ColorPickerColor = color.hexString;
                    postNUI('ChangeVehicleColorFromPopup', this.ColorPickerColor)
                });
            });
        },

        ChangeVehicleColorFromSelector() {
            this.ShowColorPicker = false
            postNUI('ChangeVehicleColorPermanent', this.ColorPickerColor)
            if (this.SelectedColor) {
                this.SelectedColor = null
            }
        },

        ChangePlateStatus() {
            if (this.ShowColorPicker) {
                this.ShowColorPicker = false
                this.ColorPickerColor = "#FFFFFF"
            }

            if (this.ShowPlateChange) {
                if (this.PlateInput.length <= 6 && this.PlateInput.length > 0) {
                    postNUI('CheckNewPlateStatus', this.PlateInput)
                } else {
                    if (this.PlateInput.length == 0) {
                        if (this.ChangedPlate) {
                            this.ShowPlateChange = false
                            postNUI('GenerateNewPlate')
                            this.ChangedPlate = false
                            this.ShowNotify('information', this.Language['new_generated_plate'], 4000)
                            setTimeout(() => {
                                postNUI('ResetCameraToNormal')
                            }, 1500)
                        } else {
                            this.ShowNotify('error', this.Language['dont_leave_empty'], 4000)
                        }
                    } else {
                        this.ShowNotify('error', this.Language['too_long_plate'], 3000)
                    }
                }
            } else {
                this.ShowPlateChange = true
                postNUI('ShowPlateCamera')
            }
        },

        SelectVehicle(index, v) {
            if (this.SelectedVehicleTable.VehicleIndex != index && v.stock > 0) {
                this.SelectedVehicleTable.VehicleIndex = index
                this.SelectedVehicleTable.VehicleHash = v.name
                this.SelectedVehicleTable.VehicleLabel = v.label
                this.SelectedVehicleTable.VehicleModel = v.model
                this.SelectedVehicleTable.VehiclePrice = v.price
                this.SelectedVehicleTable.VehicleStock = v.stock
                this.SelectedVehicleTable.VehicleTopSpeed = v.information.TopSpeed
                this.SelectedVehicleTable.VehicleBraking = v.information.Braking
                this.SelectedVehicleTable.VehicleAcceleration = v.information.Acceleration
                this.SelectedVehicleTable.VehicleSuspension = v.information.Suspension
                this.SelectedVehicleTable.VehicleHandling = v.information.Handling
                postNUI('CreateSelectedVehicle', this.SelectedVehicleTable.VehicleHash)
            }
        },

        SelectVehicleColor(k) {
            if (this.SelectedColor != k) {
                this.SelectedColor = k
                postNUI('ChangeVehicleColor', k)
            }
        },

        ShowMoreCar(type) {
            const div = this.$refs.vc
            if (type == 'left') {
                div.scrollBy({ left: -window.innerWidth * 1.7, behavior: 'smooth' })
            } else if (type == 'right') {
                div.scrollBy({ left: window.innerWidth * 1.7, behavior: 'smooth' })
            }
        },

        Searching() {
            if (this.SearchInput != '') {
                this.IsSearching = true
            } else {
                this.IsSearching = false
            }
        },

        OpenFeedbacks() {
            this.ShowFeedback = !this.ShowFeedback

            if (this.ShowFeedback) {
                this.$nextTick(() => {
                    const divs = this.$refs.FeedbackScrollContainer
                    if (divs) {
                        divs.forEach(div => {
                            div.addEventListener('wheel', this.HandleFeedbackScroll)
                        });
                    }
                });
            } else {
                const divs = this.$refs.FeedbackScrollContainer
                if (divs) {
                    divs.forEach(div => {
                        div.removeEventListener('wheel', this.HandleFeedbackScroll)
                    });
                }
            }
        },

        HandleFeedbackScroll(event) {
            event.preventDefault();
            event.currentTarget.scrollBy({
                top: event.deltaY * 0.2,
                behavior: 'smooth'
            });
        },

        CalculateVehicleStatistic(type) {
            return CalculateVehicleStatistic(type, this.SelectedVehicleTable, this.VehicleStatisticMaxValues)
        },

        InspectExterior() {
            if (this.CameraAngle == 'interior') {
                postNUI('MoveCamToExterior')
                this.CameraAngle = 'exterior'
            }
        },

        InspectInterior() {
            if (this.CameraAngle == 'exterior') {
                postNUI('MoveCamToInterior')
                this.CameraAngle = 'interior'
            }
        },

        LeavePreviewMode() {
            this.MainPage = 'Normal'
            this.CameraAngle = 'interior'
            this.setActivePage(false)
            this.ShiftPressed = false
            this.DraggingCheck = false
            this.MouseX = null
            this.MouseY = null
            postNUI('ResetCameraAngle')
            this.InspectExterior()
        },

        ShowNotify(type, text, ms) {
            ShowNotify(type, text, ms, this.NotifySettings, SoundPlayer)
        },

        ShowPopup(type, headerone, headertwo, description, fnc) {
            this.ShowPopupScrren = true
            if (type == 'normal') {
                this.NormalPopupSettings.Show = true
                this.NormalPopupSettings.HeaderOne = headerone
                this.NormalPopupSettings.HeaderTwo = headertwo
                this.NormalPopupSettings.Description = description
                this.NormalPopupSettings.Function = fnc
            }
        },

        ClosePopup(type) {
            this.ShowPopupScrren = false
            if (type == 'normal') {
                this.NormalPopupSettings.Show = false
                this.NormalPopupSettings.HeaderOne = ''
                this.NormalPopupSettings.HeaderTwo = ''
                this.NormalPopupSettings.Description = ''
                this.NormalPopupSettings.Function = null
            } else if (type == 'feedback') {
                this.FeedbackPopupSettings.Show = false
                this.FeedbackPopupSettings.Rating = null
                this.FeedbackPopupSettings.Message = ''
                // postNUI('CloseUI')
            } else if (type == 'complaint') {
                this.ComplaintPopupSettings.Show = false
                this.ComplaintPopupSettings.Message = ''
                // postNUI('CloseUI')
            }
        },

        SendFeedback() {
            if (this.FeedbackPopupSettings.Rating) {
                if (this.FeedbackPopupSettings.Message.length >= this.FeedbackCharacters.MinimumCharacter) {
                    if (this.FeedbackPopupSettings.Message.length <= this.FeedbackCharacters.MaximumCharacter) {
                        if (this.CheckProfanities) {
                            const SearchProfanities = this.Profanities.filter(v => this.FeedbackPopupSettings.Message.includes(v))
                            if (SearchProfanities.length == 0) {
                                // Table Insert (this.Feedbacks)
                            } else {
                                this.ShowNotify('error', this.Language['feedback_stop_using_bad_words'], 8000)
                            }
                        } else {
                            // Table Insert (this.Feedbacks)
                        }
                    } else {
                        this.ShowNotify('error', this.Language['feedback_maximum_character'], 4000)
                    }
                } else {
                    this.ShowNotify('error', this.Language['feedback_minimum_character'], 4000)
                }
            } else {
                this.ShowNotify('error', this.Language['choose_point'], 4000)
            }
        },

        SendComplaint() {
            if (this.ComplaintPopupSettings.Message.length >= this.ComplaintCharacters.MinimumCharacter) {
                if (this.ComplaintPopupSettings.Message.length <= this.ComplaintCharacters.MaximumCharacter) {
                    if (this.CheckProfanities) {
                        const SearchProfanities = this.Profanities.filter(v => this.ComplaintPopupSettings.Message.includes(v))
                        if (SearchProfanities.length == 0) {
                            // Table Insert (this.ComplainTable)
                        } else {
                            this.ShowNotify('error', this.Language['complaint_stop_using_bad_words'], 8000)
                        }
                    } else {
                        // Table Insert (this.ComplainTable)
                    }
                } else {
                    this.ShowNotify('error', this.Language['complaint_maximum_character'], 4000)
                }
            } else {
                this.ShowNotify('error', this.Language['complaint_minimum_character'], 4000)
            }
        },

        TotalBossmenuPages(type) {
            if (type == 'preorder') {
                return Math.ceil(this.Preorders.length / 7)
            } else if (type == 'soldvehicles') {
                return Math.ceil(this.FilterSoldVehiclesPage.length / 7)  
            } else if (type == 'transaction') {
                return Math.ceil(this.FilterTransactionsPage.length / 8) 
            } else if (type == 'employeewithpenalty') {
                return Math.ceil(this.FilterEmployeesWithPenaltyTable.length / 1)
            } else if (type == 'employee') {
                return Math.ceil(this.FilterEmployeesTable.length / 8)
            }
        },

        NextPage(type) {
            if (type == 'preorder') {
                if (this.BossmenuPageSettings.PreorderPage < this.TotalBossmenuPages('preorder')) {
                    this.BossmenuPageSettings.PreorderPage++
                }
            } else if (type == 'soldvehicles') {
                if (this.BossmenuPageSettings.SoldVehiclesPage < this.TotalBossmenuPages('soldvehicles')) {
                    this.BossmenuPageSettings.SoldVehiclesPage++
                }
            } else if (type == 'transaction') {
                if (this.BossmenuPageSettings.TransactionsPage < this.TotalBossmenuPages('transaction')) {
                    this.BossmenuPageSettings.TransactionsPage++
                }
            } else if (type == 'employeewithpenalty') {
                if (this.BossmenuPageSettings.EmployeeWithPenaltyPage < this.TotalBossmenuPages('employeewithpenalty')) {
                    this.BossmenuPageSettings.EmployeeWithPenaltyPage++
                }
            } else if (type == 'employee') {
                if (this.BossmenuPageSettings.EmployeesPage < this.TotalBossmenuPages('employee')) {
                    this.BossmenuPageSettings.EmployeesPage++
                }
            }
        },

        PrevPage(type) {
            if (type == 'preorder') {
                if (this.BossmenuPageSettings.PreorderPage > 1) {
                    this.BossmenuPageSettings.PreorderPage--
                }
            } else if (type == 'soldvehicles') {
                if (this.BossmenuPageSettings.SoldVehiclesPage > 1) {
                    this.BossmenuPageSettings.SoldVehiclesPage--
                }
            } else if (type == 'transaction') {
                if (this.BossmenuPageSettings.TransactionsPage > 1) {
                    this.BossmenuPageSettings.TransactionsPage--
                }
            } else if (type == 'employeewithpenalty') {
                if (this.BossmenuPageSettings.EmployeeWithPenaltyPage > 1) {
                    this.BossmenuPageSettings.EmployeeWithPenaltyPage--
                }
            } else if (type == 'employee') {
                if (this.BossmenuPageSettings.EmployeesPage > 1) {
                    this.BossmenuPageSettings.EmployeesPage--
                }
            }
        },

        // Perms
        CreatePerm() {
            // NOTE: Perm check, Existing name check, Existing label check

            this.ShowBossPopup = 'createperm'
            // Name input: this.Inputs.PermNameInput
            // Label input: this.Inputs.PermLabelInput
            // Vehicleshop: this.CurrentVehicleshop
        },

        RemovePerm(k) {
            // NOTE: Perm check

            // postNUI('RemovePerm', {
            //     vehicleshop: this.CurrentVehicleshop,
            //     name: this.PermsTable[k].name,
            // })
        },

        TogglePerms(k) {
            if (this.SelectedPerm < 0) return;

            if (!this.OriginalPermsTable) {
                this.OriginalPermsTable = JSON.parse(JSON.stringify(this.PermsTable[this.SelectedPerm].permissions));
            }
            let table = this.PermsTable[this.SelectedPerm].permissions;
            let permission = table[k];
            permission.value = !permission.value;
            this.$forceUpdate();
        },

        ResetPermsToggle() {
            if (this.OriginalPermsTable) {
                this.PermsTable[this.SelectedPerm].permissions = JSON.parse(JSON.stringify(this.OriginalPermsTable));
                this.OriginalPermsTable = null;
                this.$forceUpdate();
            }
        },

        SaveNewPermissions() {
            // NOTE: Perm check

            if (this.OriginalPermsTable) {
                this.PermsTable[this.SelectedPerm].permissions = JSON.parse(JSON.stringify(this.OriginalPermsTable));
                this.OriginalPermsTable = null;
                // postNUI('SaveNewPermissions', { // Bu kısım açılacak
                //     vehicleshop: this.CurrentVehicleshop,
                //     name: this.PermsTable[this.SelectedPerm].name,
                //     table: this.PermsTable[this.SelectedPerm].permissions,
                // })
            } else {
                // Değişiklik yapılmamış hatası/notify
            }
        },

        // Feedback & Complaint
        RemoveFeedbackComplaint(k, name, message) {
            // NOTE: Perm check
            // k = table number | name = player name (For check) | message = player message (For check) | Vehicleshop: this.CurrentVehicleshop
            // this.FeedbackComplaintScreen = -1
        },

        // Edit Vehicle
        OpenEditVehicleScreen(k, label, model, img, discount, price, category) {
            // NOTE: Perm check

            const CategoryIndex = this.CategoryList.findIndex(v => v.name == category)
            this.SelectedVehicleEditCategory = CategoryIndex
            this.ShowBossPopup = 'vehicleedit'
            this.VehicleEditScreen = k
            this.EditVehicleInputs.Name = label
            this.EditVehicleInputs.Model = model
            this.EditVehicleInputs.Img = img
            this.EditVehicleInputs.Discount = discount
            this.EditVehicleInputs.Price = price
        },

        CloseEditVehicleScreen() {
            this.SelectedVehicleEditCategory = -1
            this.ShowBossPopup = ''
            this.VehicleEditScreen = -1
            this.EditVehicleInputs.Name = ''
            this.EditVehicleInputs.Model = ''
            this.EditVehicleInputs.Img = ''
            this.EditVehicleInputs.Discount = ''
            this.EditVehicleInputs.Price = ''
        },

        SaveEditVehicleSection() {
            // this.CurrentVehicleshop
            
            if (this.BossMenuFilterVehicles[ this.VehicleEditScreen].label == this.EditVehicleInputs.Name && this.BossMenuFilterVehicles[ this.VehicleEditScreen].model == this.EditVehicleInputs.Model && this.BossMenuFilterVehicles[ this.VehicleEditScreen].img == this.EditVehicleInputs.Img && this.BossMenuFilterVehicles[ this.VehicleEditScreen].discount == this.EditVehicleInputs.Discount && this.BossMenuFilterVehicles[ this.VehicleEditScreen].price == this.EditVehicleInputs.Price) {
                // No change notify
            } else {
                // Change action
            }
        },

        // Category Page
        CategoryPageFilterVehicle(type) {
            if (type == 'all') {
                return this.VehiclesTable.filter(v => v.stock > 0)
            } else {
                return this.VehiclesTable.filter(v => v.category == type && v.stock > 0)
            }
        },

        CreateCategory() {
            // NOTE: Perm check, Existing name check, Existing label check

            // Name input: this.Inputs.PermNameInput
            // Label input: this.Inputs.PermLabelInput
            // Vehicleshop: this.CurrentVehicleshop
        },

        RemoveCategory(name) {
            // NOTE: Perm check and If category has vehicle check

            // Close popup (this.ShowBossPopup)
            // this.SelectedShowCategory
            // this.CategoryList
            // this.CurrentVehicleshop
        },

        EditCategory(label) {
            // this.SelectedShowCategory
            // this.Inputs.CategoryLabelInput
        },

        // Buy Vehicle Page
        BuyVehicleSection() {
            // NOTE: Perm check

            // this.CurrentVehicleshop
            // Alt kısımda bilgiler var
        },

        CloseBuyVehicleSection() {
            this.ShowBossPopup = ''
            this.SelectedBuyVehicle = -1
            this.BuyVehicleInputs = {
                Stock: 1,
                Price: '',
                SelectedCategoryIndex: -1
            }
        },

        // Buy vehicleshop & Transfer Req
        TransferReqFunction() {
            if (this.TransferReqFunctions == 'buycompany') {
                postNUI('BuyCompany', {
                    id: this.CurrentVehicleshop,
                    price: this.TransferReqCompanyPrice,
                })
            }
        },

        CloseTransferReq() {
            if (this.TransferReqFunctions == 'buycompany') {
                this.ShowPopupToTarget = ''
                this.CurrentVehicleshop = -1
                this.TransferReqCompanyPrice = 0
                this.TransferReqCompanyName = ''
                this.TransferReqFunctions = ''
                postNUI('SetNuiFocus', false)
            }
        },

        // Deposit & Withdraw
        DepositMoney() {
            if (this.Inputs.DepositInput > 0) {
                postNUI('DepositMoney', {
                    id: this.CurrentVehicleshop,
                    value: this.Inputs.DepositInput
                })
                this.Inputs.DepositInput = ''
                this.ShowBossPopup = ''
            } else {
                this.ShowNotify('error', this.Language['dont_leave_empty'], 3000)
            }
        },

        WithdrawMoney() {
            if (this.Inputs.WithdrawInput > 0) {
                postNUI('WithdrawMoney', {
                    id: this.CurrentVehicleshop,
                    value: this.Inputs.WithdrawInput
                })
                this.Inputs.WithdrawInput = ''
                this.ShowBossPopup = ''
            } else {
                this.ShowNotify('error', this.Language['dont_leave_empty'], 3000)
            }
        },

        // Perm Check
        PermCheck(name, action) {
            let Author = this.PermsTable.find(v => v.label == name)
            let Permission = Author.permissions.find(v => v.name == action)
            if (Permission.value) {
                return true
            } else {
                this.ShowNotify('error', this.Language['not_allowed'], 3000)
                return false
            }
        },

        // Camera angles
        HandleZoomScroll(event) {
            if (this.ShiftPressed) {
                if (event.deltaY < 0) {
                    postNUI('ZoomIn')
                } else {
                    postNUI('ZoomOut')
                }
            }
        },

        RotateCamera(event) {
            if (this.DraggingCheck) {
                if (!this.ShiftPressed) {
                    if (this.MouseX != null) {
                        if (event.clientX > this.MouseX) {
                            postNUI('RotateCameraRight')
                        } else if (event.clientX < this.MouseX) {
                            postNUI('RotateCameraLeft')
                        }
                    }
                }
                if (this.CameraAngle == 'interior' && this.ShiftPressed) {
                    if (this.MouseY != null) {
                        if (event.clientY > this.MouseY) {
                            postNUI('RotateCameraUp')
                        } else if (event.clientY < this.MouseY) {
                            postNUI('RotateCameraDown')
                        }
                    }
                }
                this.MouseX = event.clientX
                this.MouseY = event.clientY
            }
        },

        // CloseUI
        CloseUI(status) {
            this.Show = false
            this.MainPage = 'Normal'
            this.activePage = 'dashboard'
            this.HasOwner = false
            this.SelectedColor = null
            this.SelectedVehicleTable = {
                VehicleIndex: -1,
                VehicleHash: "",
                VehicleLabel: "",
                VehicleModel: "",
                VehiclePrice: 0,
                VehicleTopSpeed: 0,
                VehicleBraking: 0,
                VehicleAcceleration: 0,
                VehicleSuspension: 0,
                VehicleHandling: 0,
            }
            this.VehiclesTable = []
            this.Feedbacks = []
            this.CategoryList = []
            this.SearchInput = ""
            this.PlateInput = ""
            this.ShowPlateChange = false
            this.IsSearching = false
            this.ShowFeedback = false
            this.ShowPopupScrren = false
            this.NormalPopupSettings = {
                Show: false,
                HeaderOne: '',
                HeaderTwo: '',
                Description: '',
                Function: null
            }
            this.FeedbackPopupSettings = {
                Show: false,
                Rating: null,
                Message: '',
            }
            this.ComplaintPopupSettings = {
                Show: false,
                Message: '',
            }
            this.ComplainTable = []
            this.EditVehicleInputs = {
                Name: '',
                Model: '',
                Img: '',
                Discount: '',
                Price: '',
            }
            this.SelectedShowCategory = 0
            this.BuyVehicleInputs = {
                Stock: 1,
                Price: '',
                SelectedCategoryIndex: -1
            }
            this.ShiftPressed = false
            this.DraggingCheck = false
            this.MouseX = null
            this.MouseY = null
            this.CameraAngle = 'exterior'
            if (this.MainPage == 'Component' && this.activePage == 'preview') {
                this.LeavePreviewMode()
            }
            postNUI('CloseUI', status)
        },

        CloseBossmenu() {
            this.Show = false
            this.MainPage = 'Normal'
            this.activePage = 'dashboard'
            this.Inputs = {
                SoldVehiclesInput: '',
                CompanyNameInput: '',
                TransferIdInput: '',
                TransferPriceInput: '',
                DiscountInput: '',
                BonusesInput: '',
                RaiseInput: '',
                TransactionsInput: '',
                EmployeeIdInput: '',
                EmployeeSalaryInput: '',
                SalaryPenaltyIdInput: '',
                SalaryPenaltyInput: '',
                PenaltySearchInput: '',
                EmployeesInput: '',
                DepositInput: '',
                WithdrawInput: '',
                PermNameInput: '',
                PermLabelInput: '',
            }
            this.SelectedBossmenuCategory = 0
            this.VehiclesTable = []
            this.Feedbacks = []
            this.CategoryList = []
            this.CompanyMoney = 0
            this.Preorders = []
            this.EmployeesTable = []
            this.SoldVehiclesLog = []
            this.Transactions = []
            this.PermsTable = []
            this.CompanyMoney = 0
            this.SelectedPerm = -1
            this.OriginalPermsTable = null
            this.BossmenuPageSettings = {
                PreorderPage: 1,
                SoldVehiclesPage: 1,
                TransactionsPage: 1,
                EmployeeWithPenaltyPage: 1,
                EmployeesPage: 1,
            }
            this.FeedbackComplaintScreen = -1
            this.VehicleEditScreen = -1
            this.CurrentVehicleshop = -1
            this.NotifySettings = {
                Show: false,
                Type: '',
                Message: '',
                Time: 0,
            }
            this.ComplainTable = []
            this.EditVehicleInputs = {
                Name: '',
                Model: '',
                Img: '',
                Discount: '',
                Price: '',
            }
            this.SelectedShowCategory = 0
            this.BuyVehicleInputs = {
                Stock: 1,
                Price: '',
                SelectedCategoryIndex: -1
            }
            postNUI('CloseBossmenu')
        },

        // Events
        HandleKeyDown(event) {
            if (event.key === 'Shift') {
                this.ShiftPressed = true
            }
        },

        HandleKeyUp(event) {
            if (event.key === 'Shift') {
                this.ShiftPressed = false
            }
        },

        LeftClickCheck(event) {
            if (event.button === 0) {
                this.DraggingCheck = true
                this.MouseX = event.clientX
                this.MouseY = event.clientY
            }
        },

        LeaveLeftClick(event) {
            if (event.button === 0) {
                this.DraggingCheck = false
            }
        },
    },  
    
    computed: {
        FilterVehicles() {
            let x = this.VehiclesTable

            if (this.SelectedVehicleCategory !== 'all') {
                x = x.filter(v => v.category == this.SelectedVehicleCategory)
            }

            if (this.IsSearching && this.SearchInput != '') {
                return x.filter(v => v.name.toLowerCase().includes(this.SearchInput.toLowerCase()) || v.label.toLowerCase().includes(this.SearchInput.toLowerCase()) || v.model.toLowerCase().includes(this.SearchInput.toLowerCase()))
            }

            return x
        },

        BossMenuFilterVehicles() {
            let x = this.VehiclesTable

            if (this.IsSearching && this.SearchInput != '') {
                return x.filter(v => v.name.toLowerCase().includes(this.SearchInput.toLowerCase()) && v.stock > 0 || v.label.toLowerCase().includes(this.SearchInput.toLowerCase()) && v.stock > 0 || v.model.toLowerCase().includes(this.SearchInput.toLowerCase()) && v.stock > 0)
            } else {
                return x.filter(v => v.stock > 0)
            }
        },

        NotifyColor() {
            switch (this.NotifySettings.Type) {
                case 'success':
                  return '#00F0FF';
                case 'information':
                  return '#00FFB7';
                case 'error':
                  return '#FF0004';
                default:
                  return '';
            }
        },

        AvailableVehiclesCount() {
            return this.VehiclesTable.filter(v => v.stock > 0).length;
        },

        AverageRating() {
            if (this.Feedbacks.length == 0) {
                return 0;
            }

            const rating = this.Feedbacks.reduce((k, v) => k + v.stars, 0);
            return (rating / this.Feedbacks.length).toFixed(1);
        },

        PreordersPage() {
            const s = (this.BossmenuPageSettings.PreorderPage - 1) * 7
            const e = s + 7
            return this.Preorders.slice(s, e)
        },

        FilterSoldVehiclesPage() {
            if (!this.Inputs.SoldVehiclesInput) {
                return this.SoldVehiclesLog
            } 
            return this.SoldVehiclesLog.filter(v => {
                return (
                    v.buyer.toLowerCase().includes(this.Inputs.SoldVehiclesInput.toLowerCase()) ||
                    v.vehicle.toLowerCase().includes(this.Inputs.SoldVehiclesInput.toLowerCase()) ||
                    v.price.toString().includes(this.Inputs.SoldVehiclesInput)
                )
            })
        },

        SoldVehiclesPage() {
            const s = (this.BossmenuPageSettings.SoldVehiclesPage - 1) * 7
            const e = s + 7
            return this.FilterSoldVehiclesPage.slice(s, e)
        },

        FilterTransactionsPage() {
            if (!this.Inputs.TransactionsInput) {
                return this.Transactions
            }

            const input = this.Inputs.TransactionsInput.toLowerCase();

            return this.Transactions.filter(v => {
                if (input === 'withdraw' || input === 'deposit') {
                    return v.type.toLowerCase() === input;
                }
                return (
                    v.name.toLowerCase().includes(input) ||
                    v.amount.toString().includes(this.Inputs.TransactionsInput)
                );
            });
        },

        TransactionsPage() {
            const s = (this.BossmenuPageSettings.TransactionsPage - 1) * 8
            const e = s + 8
            return this.FilterTransactionsPage.slice(s, e)
        },

        FilterEmployeesWithPenaltyTable() {
            if (!this.Inputs.PenaltySearchInput) {
                return this.EmployeesTable.filter(v => v.salarypenalty > 0);
            }

            const input = this.Inputs.PenaltySearchInput.toLowerCase();

            return this.EmployeesTable.filter(v => {
                return (
                    v.name.toLowerCase().includes(input) &&
                    v.salarypenalty > 0 ||
                    v.identifier.toLowerCase().includes(input) &&
                    v.salarypenalty > 0 ||
                    v.salary.toString().includes(this.Inputs.PenaltySearchInput) &&
                    v.salarypenalty > 0
                );
            });
        },

        EmployeeWithPenaltyPage() {
            const s = (this.BossmenuPageSettings.EmployeeWithPenaltyPage - 1) * 1
            const e = s + 1
            return this.FilterEmployeesWithPenaltyTable.slice(s, e)
        },

        FilterEmployeesTable() {
            if (!this.Inputs.EmployeesInput) {
                return this.EmployeesTable
            }

            const input = this.Inputs.EmployeesInput.toLowerCase();

            return this.EmployeesTable.filter(v => {
                return (
                    v.name.toLowerCase().includes(input) ||
                    v.identifier.toLowerCase().includes(input) ||
                    v.salary.toString().includes(this.Inputs.EmployeesInput)
                );
            });
        },

        EmployeesPage() {
            const s = (this.BossmenuPageSettings.EmployeesPage - 1) * 8
            const e = s + 8
            return this.FilterEmployeesTable.slice(s, e)
        },

        FeedbackAndComplaintsTable() {
            const complaints = this.ComplainTable.map(item => ({
              ...item,
              type: 'complaint'
            }));
      
            const feedbacks = this.Feedbacks.map(item => ({
              ...item,
              type: 'feedback'
            }));
      
            return [...complaints, ...feedbacks];
        },

        FilterCategories() {
            return this.CategoryList.filter(v => v.name != 'all')
        },
    },

    watch: {
        'Inputs.SoldVehiclesInput'() {
            this.BossmenuPageSettings.SoldVehiclesPage = 1;
        },

        'Inputs.TransactionsInput'() {
            this.BossmenuPageSettings.TransactionsPage = 1;
        },

        'Inputs.PenaltySearchInput'() {
            this.BossmenuPageSettings.EmployeeWithPenaltyPage = 1;
        },

        'Inputs.EmployeesPage'() {
            this.BossmenuPageSettings.EmployeesPage = 1;
        }
    },

    beforeDestroy() {
        window.removeEventListener('keydown', this.HandleKeyDown);
        window.removeEventListener('keyup', this.HandleKeyUp);
    },
    
    mounted() {
        window.addEventListener("message", event => {
            const data = event.data;
            switch (data.action) {
                case 'Setup':
                    this.Language = data.language
                    this.ColorsTable = data.colorstable
                    this.BossmenuCategory = data.bossmenucategories
                    this.CheckProfanities = data.checkprofanities
                    this.Profanities = data.profanities
                    this.FeedbackCharacters = data.feedbackcharacters
                    this.ComplaintCharacters = data.complaintcharacters
                    this.TestDrivePrice = data.testdriveprice
                    this.AllowPlateChange = data.platechange
                    this.PlateChangePrice = data.platechangeprice
                    break;
                case 'OpenVehicleshop':
                    this.Show = true
                    this.MainPage = 'Normal'
                    this.HasOwner = data.hasowner
                    this.AllVehicleData = data.allvehiclestable
                    this.PlayerName = data.playername
                    this.PlayerMoney = data.playermoney
                    this.PlayerPfp = data.playerpfp
                    this.CurrentVehicleshop = data.vehicleshop
                    this.VehicleShopName = data.vehicleshopname
                    this.VehicleshopDescription = data.vehicleshopdescription
                    this.VehicleShopStar = data.vehicleshoprating
                    this.VehiclesTable = data.vehicles
                    this.CategoryList = data.categories
                    this.Feedbacks = data.feedbacks
                    this.Discount = data.discount
                    this.Raise = data.raise
                    break;
                case 'UpdateCreateSelectedVehicle':
                    this.SelectedVehicleTable.VehicleTopSpeed = data.speed
                    this.SelectedVehicleTable.VehicleBraking = data.brake
                    this.SelectedVehicleTable.VehicleAcceleration = data.acceleration
                    this.SelectedVehicleTable.VehicleSuspension = data.suspension
                    this.SelectedVehicleTable.VehicleHandling = data.handling
                    this.PlateInput = data.plate
                    this.CurrentVehicleColor = data.color
                    break;
                case 'ChangeCurrentVehicleColorStatus':
                    this.CurrentVehicleColor = data.color
                    break;
                case 'UpdatePlateInput':
                    this.PlateInput = data.value
                    break;
                case 'ShowTestDriveTime':
                    if (!this.ShowTestDriveTime) {
                        this.ShowTestDriveTime = true
                    }
                    this.TestDriveTime = data.time
                    break;
                case 'CloseTimer':
                    this.ShowTestDriveTime = false
                    this.TestDriveTime = 0
                    break;
                case 'ChangePlateAccepted':
                    postNUI('ChangePlate', this.PlateInput)
                    this.ShowPlateChange = false
                    this.ShowNotify('success', this.Language['successfully_changed_plate'], 2000)
                    this.ChangedPlate = true
                    setTimeout(() => {
                        postNUI('ResetCameraToNormal')
                    }, 1500)
                    break;
                case 'BuyCompany':
                    this.ShowPopupToTarget = 'TransferRequest'
                    this.CurrentVehicleshop = data.vehicleshop
                    this.TransferReqCompanyPrice = data.price
                    this.TransferReqCompanyName = data.name
                    this.TransferReqFunctions = 'buycompany'
                    break;
                case 'CloseTransferReq':
                    this.CloseTransferReq()
                    break;
                case 'OpenBossmenu':
                    this.Show = true
                    this.MainPage = 'Bossmenu'
                    this.activePage = 'dashboard'
                    this.AllVehicleData = data.allvehiclestable
                    this.CurrentVehicleshop = data.vehicleshop
                    this.PlayerName = data.playername
                    this.PlayerMoney = data.playermoney
                    this.PlayerPfp = data.playerpfp
                    this.PlayerRank = data.playerrank
                    this.VehicleShopName = data.vehicleshopname
                    this.VehicleshopDescription = data.vehicleshopdescription
                    this.CompanyMoney = data.companymoney
                    this.Feedbacks = data.feedbacks
                    this.EmployeesTable = data.employees
                    this.VehiclesTable = data.vehicles
                    this.SoldVehiclesLog = data.vehiclessold
                    this.Preorders = data.preorders
                    this.Transactions = data.transactions
                    this.PermsTable = data.perms
                    break;
                case 'UpdateUI':
                    this.PlayerMoney = data.playermoney
                    this.PlayerRank = data.playerrank
                    this.VehicleShopName = data.vehicleshopname
                    this.CompanyMoney = data.companymoney
                    this.Feedbacks = data.feedbacks
                    this.EmployeesTable = data.employees
                    this.VehiclesTable = data.vehicles
                    this.SoldVehiclesLog = data.vehiclessold
                    this.Preorders = data.preorders
                    this.Transactions = data.transactions
                    this.PermsTable = data.perms
                    break;
                case 'ShowNotify':
                    this.ShowNotify(data.type, data.text, data.ms)
                    break;
                case 'CloseUI':
                    this.CloseUI(data.status)
                    break;
                default:
                    break;
            }
        });
        
        window.addEventListener('keydown', (event) => {
            if (event.key == 'Escape') {
                if (this.Show && this.MainPage != 'Bossmenu' && this.activePage != 'preview' && this.activePage != 'companystaffsettings' && this.activePage != 'companysettings' && this.activePage != 'buyvehicle' && !this.ShowPopupScrren && !this.ShowBossPopup && !this.ShowPlateChange && !this.ShowColorPicker) {
                    this.CloseUI(true)
                }
                if (this.Show && this.MainPage == 'Bossmenu') {
                    this.CloseBossmenu()
                }
                if (this.activePage == 'preview') {
                    this.LeavePreviewMode()
                }
                if (this.activePage == 'companystaffsettings' || this.activePage == 'companysettings') {
                    this.setActivePage('company')
                    this.Inputs.CompanyNameInput = ''
                    this.Inputs.TransferIdInput = ''
                    this.Inputs.CompanyNameInput = ''
                    this.Inputs.TransferIdInput = ''
                    this.Inputs.TransferPriceInput = ''
                    this.Inputs.DiscountInput = ''
                    this.Inputs.BonusesInput = ''
                    this.Inputs.RaiseInput = ''
                    this.Inputs.EmployeeIdInput = ''
                    this.Inputs.EmployeeSalaryInput = ''
                    this.Inputs.SalaryPenaltyIdInput = ''
                    this.Inputs.SalaryPenaltyInput = ''
                    this.Inputs.PenaltySearchInput = ''
                    this.Inputs.EmployeesInput = ''
                }
                if (this.ShowPlateChange) {
                    this.ShowPlateChange = false
                    postNUI('ResetCameraToNormal')
                }
                if (this.ShowColorPicker) {
                    this.ShowColorPicker = false
                    this.SelectedColor = null
                    this.ColorPickerColor = "#FFF"
                }
                if (this.activePage == 'buyvehicle') {
                    this.setActivePage('vehicles')
                }
            } else if (event.key == 'Shift') {
                this.ShiftPressed = true
            }
        });

        window.addEventListener('keyup', this.HandleKeyUp);
    },
});

app.component('inlinesvg', inlinesvg);

app.use(store).mount("#app");

const resourceName = window.GetParentResourceName ? window.GetParentResourceName() : "real-vehicleshop";

window.postNUI = async (name, data) => {
    try {
        const response = await fetch(`https://${resourceName}/${name}`, {
            method: "POST",
            mode: "cors",
            cache: "no-cache",
            credentials: "same-origin",
            headers: {
                "Content-Type": "application/json"
            },
            redirect: "follow",
            referrerPolicy: "no-referrer",
            body: JSON.stringify(data)
        });
        return !response.ok ? null : response.json();
    } catch (error) {
        // console.log(error)
    }
};

let audioPlayer = null;
function SoundPlayer(val) {
    let audioPath = `./sounds/${val}`;
    audioPlayer = new Howl({
        src: [audioPath]
    });
    audioPlayer.volume(0.5);
    audioPlayer.play();
}