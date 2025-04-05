import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "content"]
  
  connect() {
    this.showTab(this.tabTargets[0].dataset.tab)
  }
  
  switch(event) {
    event.preventDefault()
    const selectedTab = event.currentTarget.dataset.tab
    this.showTab(selectedTab)
  }
  
  showTab(tabName) {
    this.tabTargets.forEach(tab => {
      tab.classList.toggle('active', tab.dataset.tab === tabName)
    })
    
    this.contentTargets.forEach(content => {
      content.style.display = content.id === `${tabName}-search` ? 'block' : 'none'
    })
    
    // Update URL hash without scrolling
    history.pushState(null, null, `#${tabName}-search`)
  }
}
