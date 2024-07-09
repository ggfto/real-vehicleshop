async function importTemplate(name) {
    const res = await fetch(name);
    const html = await res.text();
    return html;
}

const InlineSvg = {
    props: {
        src: {
            type: String,
            required: true
        },
        fill: {
            type: String,
            default: 'currentColor'
        }
    },
    data() {
        return {
            svg: ''
        }
    },
    async mounted() {
        const res = await fetch(this.src);
        const html = await res.text();
        this.svg = html;
    },
    async updated() {
        const res = await fetch(this.src);
        const html = await res.text();
        this.svg = html; 
    },
    template: `
        <div v-html="svg" :style="{fill:fill}" />
    `
}

const preview = {
    template: await importTemplate('./pages/preview.html')
}

const store = Vuex.createStore({
    state: {},
    mutations: {},
    actions: {}
});

const app = Vue.createApp({
    components: {
        preview,
        InlineSvg
    },
    
    data: () => ({
        Show: true,
        MainPage: 'Component', // 'Normal', 'Preview'
        activePage: 'preview', // 'preview'
        HasOwner: true,

        // Player Information
        PlayerName: "Oph3Z Second",
        PlayerMoney: 1000000,
        PlayerPfp: "https://cdn.discordapp.com/attachments/926499504922959922/1258479292023832709/image.png?ex=668a2bec&is=6688da6c&hm=b5c4fcc212b673d6d36c870239620b9f0574ce58944b991ff1a3e533437849f9&",

        // Vehicleshop Variables
        VehicleShopName: "Oph3Z's Dealership",
        VehicleshopDescription: "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quaerat illum aperiam neque nisi nemo itaque error voluptatem, ut minus, eaque ex similique maxime!",
        VehicleShopStar: 4,
        TestDrivePrice: 7500,
        ShowColorPicker: false,
        ColorPickerColor: "#FFF",
        SelectedColor: null,
        ColorsTable: [
            { color: "#FF5733" },
            { color: "#33FF57" },
            { color: "#3357FF" },
            { color: "#FF33A1" },
            { color: "#A133FF" },
            { color: "#33FFA1" },
            { color: "#FF5733" },
            { color: "#FFBD33" },
            { color: "#33FFBD" },
            { color: "#BD33FF" },
            { color: "#5733FF" },
            { color: "#FFA133" },
            { color: "#A1FF33" },
            { color: "#33A1FF" },
            { color: "#FF33BD" },
            { color: "#33BDFF" },
            { color: "#BDFF33" },
            { color: "#33FF57" },
            { color: "#57FF33" },
            { color: "#FF33FF" },
            { color: "#33FF33" },
            { color: "#FF3333" }
        ],
        AllowPlateChange: true,
        ShowPlateChange: false,
        PlateInput: "",
        CategoryList: [
            {
                name: 'all',
                label: 'All'
            },
            {
                name: 'sports',
                label: 'Sports'
            },
            {
                name: 'sedans',
                label: 'Sedans'
            },
            {
                name: 'suv',
                label: 'SUVs'
            },
            {
                name: 'trucks',
                label: 'Trucks'
            },
        ],
        SelectedVehicleCategory: 'all',
        VehiclesTable: [
            {
                name: 't20',
                label: 'T20',
                model: 'Super',
                category: 'sports',
                price: 1000000,
                stock: 20,
                img: 'https://docs.fivem.net/vehicles/t20.webp',
            },
            {
                name: 'elegy',
                label: 'Elegy',
                model: 'Custom',
                category: 'sports',
                price: 2500000,
                stock: 0,
                img: 'https://docs.fivem.net/vehicles/elegy.webp',
            },
            {
                name: 'sultanrs',
                label: 'Sultan RS',
                model: 'Normal',
                category: 'sedans',
                price: 1000000,
                stock: 2,
                img: 'https://docs.fivem.net/vehicles/sultanrs.webp',
            },
            {
                name: 'sultanrs',
                label: 'Sultan RS',
                model: 'Normal',
                category: 'sedans',
                price: 1000000,
                stock: 2,
                img: 'https://docs.fivem.net/vehicles/sultanrs.webp',
            },
            {
                name: 'sultanrs',
                label: 'Sultan RS',
                model: 'Normal',
                category: 'sedans',
                price: 1000000,
                stock: 2,
                img: 'https://docs.fivem.net/vehicles/sultanrs.webp',
            },
            {
                name: 'sultanrs',
                label: 'Sultan RS',
                model: 'Normal',
                category: 'sedans',
                price: 1000000,
                stock: 2,
                img: 'https://docs.fivem.net/vehicles/sultanrs.webp',
            },
        ],
        SelectedVehicleTable: {
            VehicleIndex: -1,
            VehicleLabel: "",
            VehicleModel: "",
            VehiclePrice: 0,
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
        ],
        VehicleStatisticMaxValues: {
            MaxSpeed: 500,
            MaxBrake: 300,
            MaxAcceleration: 250,
            MaxSuspension: 400,
            MaxHandling: 100
        },

        // Language
        Language: {
            // UI
            ['vehicle_setup_and_information']: "Vehicle Information & Setup",
            ['price']: "Price",
            ['buy_this_car']: "Buy this car",
            ['test_drive']: "Test Drive",
            ['preview']: "Preview",
            ['change_plate']: "Change Plate",
            ['colors']: "Colors",
            ['color_settings']: "Color Settings",
            ['color_hex']: "Color Hex",
            ['change_color']: "Change Color",
            ['search']: "Search",
            ['type']: "Type",
            ['car_list']: "Car List",
            ['stock']: "Stock",
            ['kits']: "Kits",
            ['top_speed']: "Top Speed",
            ['braking']: "Braking",
            ['acceleration']: "Acceleration",
            ['suspension']: "Suspension",
            ['handling']: "Handling",
            ['exit_preview']: "Exit Preview",
            ['inspect_exterior']: "Inspect Exterior",
            ['inspect_interior']: "Inspect Interior",
            ['preview_mode_information_text']: "Rotate the car for better view!",
        },
    }),

    methods: {
        setActivePage(page) {
            this.activePage = page
        },

        FormatMoney(s) {
            s = parseInt(s)
            return s.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.')
        },

        TestDrive() {
            // Test Drive Codes
        },

        SetColorPicker() {
            this.ShowColorPicker = !this.ShowColorPicker

            if (this.ShowPlateChange) {
                this.ShowPlateChange = false
                this.PlateInput = ""
            }

            if (this.ShowColorPicker) {
                this.OpenColorPicker()
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
                });
            });
        },

        ChangePlateStatus() {
            this.ShowPlateChange = !this.ShowPlateChange

            if (this.ShowColorPicker) {
                this.ShowColorPicker = false
            }

            if (!this.ShowPlateChange) {
                if (this.PlateInput.length >= 6) {
                    // Change Plate Functions
                }
            }
        },

        SelectVehicle(index, v) {
            if (this.SelectedVehicleTable.VehicleIndex != index && v.stock > 0) {
                this.SelectedVehicleTable.VehicleIndex = index
                this.SelectedVehicleTable.VehicleLabel = v.label
                this.SelectedVehicleTable.VehicleModel = v.model
                this.SelectedVehicleTable.VehiclePrice = v.price
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
            let value
            if (type === 'speed') {
              value = Math.round((20 / this.VehicleStatisticMaxValues.MaxSpeed) * 100);
            } else if (type === 'brake') {
              value = Math.round((125 / this.VehicleStatisticMaxValues.MaxBrake) * 100);
            } else if (type === 'acceleration') {
              value = Math.round((87 / this.VehicleStatisticMaxValues.MaxAcceleration) * 100);
            } else if (type === 'suspension') {
              value = Math.round((100 / this.VehicleStatisticMaxValues.MaxSuspension) * 100);
            } else if (type === 'handling') {
              value = Math.round((54 / this.VehicleStatisticMaxValues.MaxHandling) * 100);
            }
            
            return value < 60 ? 67 : value;
        }
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
        }
    },

    watch: {
    },

    beforeDestroy() {
        window.removeEventListener('keyup', this.onKeyUp);
    },
    
    mounted() {
        window.addEventListener("message", event => {
            const data = event.data;
            
            if (data.action == 'OpenUI') {
                // Content
            }
        });
        
        window.addEventListener('keydown', (event) => {
            if (event.key == 'Escape') {
                if (this.Show) {
                    postNUI('CloseUI')
                }
                if (this.ShowPlateChange) {
                    this.ShowPlateChange = false
                    this.PlateInput = ""
                }
            } 
        });
    },
});

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